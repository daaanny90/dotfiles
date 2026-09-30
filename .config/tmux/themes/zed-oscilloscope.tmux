################################################################################
# TMUX THEME: Zed Oscilloscope (matches Neovim zed-oscilloscope)
################################################################################

# Status bar colors
# Background: neutral graphite instrument body, Foreground: cool light gray
set -g status-style "bg=#1e1f1c,fg=#c4c9bc"

# Left side: session name
# Using phosphor-green accent for session name
set -g status-left-length 50
set -g status-left "#[fg=#8fd072,bold] #S #[fg=#667058]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#adb2a5]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: subtle gray-green (comment color)
set -g window-status-format "#[fg=#667058] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d96a5a]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: phosphor green
set -g window-status-current-format "#[fg=#8fd072,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d96a5a]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive border: subtle graphite line
set -g pane-border-style "fg=#2f322c"
# Active border: phosphor green
set -g pane-active-border-style "fg=#8fd072"

# Message colors (elevated surface)
set -g message-style "bg=#262723,fg=#c4c9bc"
