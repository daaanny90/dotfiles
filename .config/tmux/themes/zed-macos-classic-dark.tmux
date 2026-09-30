################################################################################
# TMUX THEME: Zed macOS Classic Dark (matches Neovim zed-macos-classic-dark)
################################################################################

# Status bar colors
# Background: Zed status_bar.background, Foreground: editor text
set -g status-style "bg=#272727,fg=#caccca"

# Left side: session name
# Using the amber-gold accent (function/title color) for session name
set -g status-left-length 50
set -g status-left "#[fg=#fdd888,bold] #S #[fg=#9e9e9e]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#9e9e9e]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: muted gray
set -g window-status-format "#[fg=#9e9e9e] #I:#W#{?#{>:#{window_panes},1}, #[fg=#c74028]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: amber gold
set -g window-status-current-format "#[fg=#fdd888,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#c74028]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive border: Zed border.variant
set -g pane-border-style "fg=#3a3a3a"
# Active border: amber gold
set -g pane-active-border-style "fg=#fdd888"

# Message colors (elevated surface)
set -g message-style "bg=#1e1d1e,fg=#dddddd"
