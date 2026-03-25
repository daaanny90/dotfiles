################################################################################
# TMUX THEME: Everforest
################################################################################

# Status bar colors (Everforest theme)
# Background: dark everforest bg, Foreground: fg
set -g status-style "bg=#272e33,fg=#d3c6aa"

# Left side: session name
# Using everforest green for session name
set -g status-left-length 50
set -g status-left "#[fg=#a7c080,bold] #S #[fg=#d3c6aa]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#d3c6aa]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: subtle gray
set -g window-status-format "#[fg=#7a8478] #I:#W#{?#{>:#{window_panes},1}, #[fg=#e67e80]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: bright green
set -g window-status-current-format "#[fg=#a7c080,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#e67e80]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors (Everforest theme)
# Inactive border: subtle dark gray
set -g pane-border-style "fg=#3d484d"
# Active border: everforest green
set -g pane-active-border-style "fg=#a7c080"

# Message colors (Everforest theme)
set -g message-style "bg=#3d484d,fg=#d3c6aa"


