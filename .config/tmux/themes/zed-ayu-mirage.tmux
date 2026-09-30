################################################################################
# TMUX THEME: Zed Ayu Mirage (matches Neovim zed-ayu-mirage)
################################################################################

# Status bar colors
# Background: editor.background, Foreground: editor.foreground
set -g status-style "bg=#242835,fg=#cccac2"

# Left side: session name
# Using Zed Ayu accent cyan for session name
set -g status-left-length 50
set -g status-left "#[fg=#72cffe,bold] #S #[fg=#5c6773]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#9a9a98]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: subtle gray (comment color)
set -g window-status-format "#[fg=#5c6773] #I:#W#{?#{>:#{window_panes},1}, #[fg=#f18779]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: accent cyan
set -g window-status-current-format "#[fg=#72cffe,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#f18779]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive border: border.variant
set -g pane-border-style "fg=#43464f"
# Active border: accent cyan
set -g pane-active-border-style "fg=#72cffe"

# Message colors (elevated surface)
set -g message-style "bg=#353944,fg=#cccac2"
