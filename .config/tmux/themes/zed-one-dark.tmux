################################################################################
# TMUX THEME: Zed One Dark (matches Neovim zed-one-dark)
################################################################################

# Status bar colors
# Background: editor.background, Foreground: editor.foreground
set -g status-style "bg=#282c33,fg=#acb2be"

# Left side: session name
# Using Zed accent blue for session name
set -g status-left-length 50
set -g status-left "#[fg=#74ade8,bold] #S #[fg=#5d636f]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#a9afbc]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
# Inactive windows: subtle gray (comment color)
set -g window-status-format "#[fg=#5d636f] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d07277]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
# Active window: accent blue
set -g window-status-current-format "#[fg=#74ade8,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d07277]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive border: border.variant
set -g pane-border-style "fg=#363c46"
# Active border: accent blue
set -g pane-active-border-style "fg=#74ade8"

# Message colors (elevated surface)
set -g message-style "bg=#2f343e,fg=#acb2be"
