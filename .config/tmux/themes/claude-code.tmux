################################################################################
# TMUX THEME: Claude Code
# Matches the newer Claude Code macOS app: neutral-dark chrome, blue accent
################################################################################

# Status bar colors (neutral-dark palette)
# Background: bg_statusline, Foreground: fg_dark
set -g status-style "bg=#1c1c1a,fg=#c3c2b7"

# Left side: session name (using blue accent)
set -g status-left-length 50
set -g status-left "#[fg=#4aa3ef,bold] #S #[fg=#c3c2b7]| "

# Right side: date and time
set -g status-right-length 130
set -g status-right "#[fg=#4aa3ef] %a %d %b #[fg=#c3c2b7]| #[fg=#4aa3ef]%H:%M "

# Window status format
# Inactive windows: muted
# Pane count indicator: blue when multiple panes
set -g window-status-format "#[fg=#73716a] #I:#W#{?#{>:#{window_panes},1}, #[fg=#4aa3ef]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Active window: blue accent, bold
set -g window-status-current-format "#[fg=#4aa3ef,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#4aa3ef]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive: subtle neutral border
set -g pane-border-style "fg=#313130"
# Active: blue accent
set -g pane-active-border-style "fg=#4aa3ef"

# Message colors
set -g message-style "bg=#20201e,fg=#e3e1d9"

# Mode style (copy/scroll mode)
set -g mode-style "bg=#313740,fg=#e3e1d9"
