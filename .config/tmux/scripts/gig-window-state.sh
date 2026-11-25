#!/usr/bin/env bash
# The claude agent's state beside each window's name: ⏳ asks you something, 🔨 works, ✓ your turn.
# gig notify (Claude Code's hooks) keeps it in the window option @gig_state; this puts it into the
# theme's window formats, right after #W (every theme has one). .tmux.conf runs it after sourcing the
# theme, so a theme switch (which sources .tmux.conf again) keeps it.
for option in window-status-format window-status-current-format; do
  format=$(tmux show -gv "$option")
  case "$format" in
    *@gig_state*) ;;
    *) tmux set -g "$option" "$(printf '%s' "$format" | sed 's/#W/#W#{?@gig_state, #{@gig_state},}/')" ;;
  esac
done
