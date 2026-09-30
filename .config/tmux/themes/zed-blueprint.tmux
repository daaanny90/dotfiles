################################################################################
# TMUX THEME: Zed Blueprint (matches Neovim zed-blueprint)
################################################################################

# Status bar colors
# Background: Prussian-blue cyanotype paper, Foreground: ice paper white
set -g status-style "bg=#212b36,fg=#c3cfda"

# Left side: session name
# Using ice-cyan accent for session name
set -g status-left-length 50
set -g status-left "#[fg=#85b8d9,bold] #S #[fg=#647486]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#aab7c4]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: subtle slate (comment color)
set -g window-status-format "#[fg=#647486] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d97a6f]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: ice cyan
set -g window-status-current-format "#[fg=#85b8d9,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d97a6f]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive border: subtle blueprint grid line
set -g pane-border-style "fg=#313d4a"
# Active border: ice cyan
set -g pane-active-border-style "fg=#85b8d9"

# Message colors (elevated surface)
set -g message-style "bg=#2a3542,fg=#c3cfda"
