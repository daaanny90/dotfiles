#!/usr/bin/env bash
# claude-popup-flag.sh — run by the session-created hook.
#
# The global detach-on-destroy is off (killing a wt-* worktree session drops
# the client back into the previous session, e.g. herole). claude-* popup
# sessions (the plugin's prefix+y flow) need the opposite: when Claude exits
# and the session dies, the nested popup client must DETACH so the popup
# closes instead of morphing into a view of another session.
# NB: set-option's target parser rejects the '=' exact-match prefix (tmux 3.5a:
# "no such session: =x"), unlike has-session/switch-client — plain names here.
tmux list-sessions -F '#{session_name}' 2>/dev/null | while read -r s; do
  case "$s" in
    claude-*) tmux set-option -t "$s" detach-on-destroy on 2>/dev/null ;;
  esac
done
exit 0
