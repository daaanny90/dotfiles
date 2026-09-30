################################################################################
# TMUX THEME: Zed Graph Paper (matches Neovim zed-graph-paper)
################################################################################

# Status bar colors
# Background: dark olive-charcoal paper, Foreground: warm paper white
set -g status-style "bg=#2a2a24,fg=#c5c2b0"

# Left side: session name
# Using burnt-orange ruler accent for session name
set -g status-left-length 50
set -g status-left "#[fg=#c2662f,bold] #S #[fg=#6e7260]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#b0ad9c]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: subtle sage gray (comment color)
set -g window-status-format "#[fg=#6e7260] #I:#W#{?#{>:#{window_panes},1}, #[fg=#cf5f4a]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: burnt orange
set -g window-status-current-format "#[fg=#c2662f,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#cf5f4a]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive border: grid line green-gray
set -g pane-border-style "fg=#3a3e33"
# Active border: burnt orange (major ruler line)
set -g pane-active-border-style "fg=#c2662f"

# Message colors (elevated surface)
set -g message-style "bg=#32322a,fg=#c5c2b0"
