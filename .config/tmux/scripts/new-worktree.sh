#!/usr/bin/env bash
# new-worktree.sh — pick/create a branch, put it in a git worktree, and open a
# Claude Code session there (integrates with craftzdog/tmux-claude-session-manager).
#
# Usage:
#   new-worktree.sh --popup <client> <cwd>
#   new-worktree.sh [--pick] [--in-popup] [--client <name>] [<branch>] [<base-ref>]
#
#   --popup       entry point for the prefix+W binding (via run-shell, which
#                 reliably expands #{q:client_name} / #{q:pane_current_path}):
#                 opens the fzf popup on that exact client and re-invokes this
#                 script inside it with --pick --in-popup --client.
#   --pick        choose the branch from an fzf list of local branches instead of
#                 passing it as an argument. Type a NEW name in the prompt + Enter
#                 to create a brand-new branch. Implied when no <branch> is given.
#   --in-popup    we are already inside a tmux popup: affects error pauses and the
#                 not-in-tmux early exit. This flag — NOT $TMUX — decides, because
#                 a popup may run with $TMUX unset.
#   --client <c>  the real (outer) client to switch to the worktree session.
#
#   <branch>      branch to work on. The worktree CHECKS OUT this branch. Reused
#                 if it exists (or already lives in a worktree); created otherwise.
#   <base-ref>    start point for a NEW branch only (default: current HEAD).
#                 Ignored when <branch> already exists.
#
# Env:
#   WORKTREE_ROOT       parent dir for new worktrees (default: sibling of the repo).
#   WORKTREE_INSTALL=1  run `pnpm install` in a freshly created worktree.
#
# Each worktree gets one human-readable tmux session, wt-<dir basename>, with
# three windows: claude, edit (nvim) and git (lazygit). The client is SWITCHED
# to it — never attached inside the popup. Note: picking the branch already checked out in the main repo
# resolves to the repo root (git forbids two checkouts of one branch), so it
# opens the session on the main checkout, not a worktree.
set -euo pipefail

# --- popup wrapper (prefix+W lands here first) --------------------------------
if [ "${1:-}" = "--popup" ]; then
  client="${2:-}"
  cwd="${3:-$PWD}"
  self="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
  exec tmux display-popup ${client:+-c "$client"} -d "$cwd" -w 90% -h 90% \
    -E "$self --pick --in-popup --client '$client'"
fi

# --- args -------------------------------------------------------------------
PICK=0
IN_POPUP=0
CLIENT=""
while [ $# -gt 0 ]; do
  case "$1" in
    --pick) PICK=1; shift ;;
    --in-popup) IN_POPUP=1; shift ;;
    --client) CLIENT="${2:-}"; shift 2 ;;
    --) shift; break ;;
    -*) echo "unknown flag: $1" >&2; exit 2 ;;
    *) break ;;
  esac
done
BRANCH="${1:-}"
BASE="${2:-}"

# In popup mode a failing exit closes the popup in one frame — pause so the user
# can read the error. Clean paths exit 0 (fzf abort) or exec (success), no pause.
pause_on_error() {
  local code=$?
  if [ "$code" -ne 0 ] && [ "$IN_POPUP" = 1 ]; then
    printf '\n[new-worktree] error (exit %s) — press Enter to close…' "$code" >&2
    read -r _ || true
  fi
}
trap pause_on_error EXIT

repo_root="$(git rev-parse --show-toplevel 2>/dev/null)" \
  || { echo "not inside a git repository" >&2; exit 1; }

plugin="$HOME/.tmux/plugins/tmux-claude-session-manager"
# shellcheck source=/dev/null
. "$plugin/scripts/helpers.sh"   # get_tmux_option, session_hash (pure defs)

# --- pick the branch (fzf; type a name to create a new one) -----------------
pick_branch() {
  local sel code query picked
  sel="$(git -C "$repo_root" branch --sort=-committerdate --format='%(refname:short)' \
    | fzf --print-query --reverse --prompt='worktree branch> ' \
          --header='Enter: use highlighted  ·  type a new name + Enter: create it' \
          --preview="git -C '$repo_root' log --oneline --color=always -n 20 {} 2>/dev/null" \
          --preview-window='right,60%')" && code=0 || code=$?
  [ "$code" -eq 130 ] && return 1   # Esc / Ctrl-C
  # --print-query prints the typed query as line 1, the selection (if any) as line 2.
  query="$(printf '%s\n' "$sel" | sed -n 1p)"
  picked="$(printf '%s\n' "$sel" | sed -n 2p)"
  printf '%s' "${picked:-$query}"
}

if [ "$PICK" = 1 ] || [ -z "$BRANCH" ]; then
  BRANCH="$(pick_branch)" || exit 0   # aborted picker -> quiet exit
fi
[ -n "$BRANCH" ] || { echo "no branch selected" >&2; exit 1; }
safe_branch="${BRANCH//\//-}"

# --- resolve worktree path (reuse the branch's existing worktree if any) -----
existing="$(git -C "$repo_root" worktree list --porcelain \
  | awk -v b="refs/heads/$BRANCH" '
      $1=="worktree"{p=substr($0,10)}
      $1=="branch" && $2==b {print p; exit}')"

if [ -n "$existing" ]; then
  wt_path="$existing"
else
  wt_root="${WORKTREE_ROOT:-$(dirname "$repo_root")}"
  wt_path="$wt_root/$(basename "$repo_root")--$safe_branch"
fi

# --- create the worktree if needed ------------------------------------------
created=0
if [ -n "$existing" ]; then
  echo "branch '$BRANCH' already in worktree: $wt_path"
elif git -C "$repo_root" worktree list --porcelain | grep -qxF "worktree $wt_path"; then
  # The dir named after this branch is a worktree, but holds a DIFFERENT branch
  # (otherwise the $existing lookup above would have matched). Opening it would
  # silently work on the wrong branch.
  actual="$(git -C "$wt_path" branch --show-current 2>/dev/null || true)"
  echo "ERROR: $wt_path is checked out on '${actual:-detached HEAD}', not '$BRANCH'." >&2
  echo "       Rename/remove it first (git worktree remove) or pick that branch instead." >&2
  exit 1
elif git -C "$repo_root" show-ref --verify --quiet "refs/heads/$BRANCH"; then
  git -C "$repo_root" worktree add "$wt_path" "$BRANCH"; created=1
else
  git -C "$repo_root" worktree add "$wt_path" -b "$BRANCH" ${BASE:+"$BASE"}; created=1
fi

# A fresh worktree does NOT share node_modules with the main checkout.
if [ "$created" = 1 ] && [ -f "$wt_path/pnpm-lock.yaml" ]; then
  if [ "${WORKTREE_INSTALL:-0}" = 1 ] && command -v pnpm >/dev/null 2>&1; then
    ( cd "$wt_path" && pnpm install ) || echo "pnpm install failed — continuing" >&2
  else
    echo "note: run 'pnpm install' in $wt_path (worktrees don't share node_modules)"
  fi
fi

# --- open the worktree session (claude + nvim + lazygit windows) -------------
# Early-exit only when we are NOT in a popup and genuinely not in tmux; the popup
# path must never take this branch even if $TMUX is unset inside it.
if [ "$IN_POPUP" != 1 ] && [ -z "${TMUX:-}" ]; then
  echo "worktree ready: $wt_path"
  echo "not in tmux — cd there and run: claude"
  exit 0
fi

cmd="$(get_tmux_option @claude_command 'claude')"
cargs="$(get_tmux_option @claude_args '')"
[ -n "$cargs" ] && cmd="$cmd $cargs"

# Human-readable session name (tmux forbids . and : in session names).
wt_name="$(basename "$wt_path")"
session="wt-${wt_name//[.:]/-}"
# A hash-named session from the old flow keeps winning, so we never end up
# with two Claudes on the same worktree; it gets the extra windows below.
legacy="$(get_tmux_option @claude_session_prefix 'claude-')$(session_hash "$wt_path")"
tmux has-session -t "=$legacy" 2>/dev/null && session="$legacy"

ensure_window() { # <name> <command> — add window to $session if missing
  tmux list-windows -t "=$session" -F '#{window_name}' 2>/dev/null | grep -qxF "$1" \
    || tmux new-window -d -t "$session:" -c "$wt_path" -n "$1" "$2"
}

tmux has-session -t "=$session" 2>/dev/null \
  || tmux new-session -d -s "$session" -c "$wt_path" -n claude "$cmd"
ensure_window edit nvim
ensure_window git lazygit

# Jump the real client there — never attach inside the popup (that showed the
# session twice and let a dying session drop the client out of tmux).
if [ -n "$CLIENT" ]; then
  exec tmux switch-client -c "$CLIENT" -t "=$session"
else
  exec tmux switch-client -t "=$session"
fi
