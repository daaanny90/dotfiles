################################################################################
# TMUX THEME: Kanagawa Dragon
################################################################################

# Status bar colors (Kanagawa Dragon theme)
# Background: darker dragon bg, Foreground: fujiGray
set -g status-style "bg=#181616,fg=#c5c9c5"

# Left side: session name
# Using dragon blue/cyan for session name
set -g status-left-length 50
set -g status-left "#[fg=#8ba4b0,bold] #S #[fg=#c5c9c5]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#c5c9c5]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: subtle gray
set -g window-status-format "#[fg=#625e5a] #I:#W#{?#{>:#{window_panes},1}, #[fg=#c4746e]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: bright cyan/blue
set -g window-status-current-format "#[fg=#8ba4b0,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#c4746e]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors (Kanagawa Dragon theme)
# Inactive border: subtle dark gray
set -g pane-border-style "fg=#282727"
# Active border: dragon blue/cyan
set -g pane-active-border-style "fg=#8ba4b0"

# Message colors (Kanagawa Dragon theme)
set -g message-style "bg=#282727,fg=#c5c9c5"


