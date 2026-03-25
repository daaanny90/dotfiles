################################################################################
# TMUX THEME: Solarized Osaka
################################################################################

# Status bar colors (Solarized Osaka theme)
set -g status-style "bg=#002c38,fg=#839395"

# Left side: session name
set -g status-left-length 50
set -g status-left "#[fg=#268bd3,bold] #S #[fg=#839395]| "

# Right side: date and time
set -g status-right-length 50
set -g status-right "#[fg=#839395]%d.%m. %H:%M "

# Window status format - just show number and name
# Show pane count indicator with superscript (▪²) when window has multiple panes - RED indicator
set -g window-status-format "#[fg=#576d74] #I:#W#{?#{>:#{window_panes},1}, #[fg=#db302d]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "
set -g window-status-current-format "#[fg=#268bd3,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#db302d]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors (Solarized Osaka theme)
set -g pane-border-style "fg=#063540"
set -g pane-active-border-style "fg=#268bd3"

# Message colors (Solarized Osaka theme)
set -g message-style "bg=#063540,fg=#839395"


