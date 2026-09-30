################################################################################
# TMUX THEME: Claude Desktop
# Matches Claude Desktop app's dark theme for visual consistency
################################################################################

# Status bar colors (Claude's warm dark palette)
# Background: bg-100, Foreground: text-200
set -g status-style "bg=#252523,fg=#c1bfb5"

# Left side: session name (using clay accent)
set -g status-left-length 50
set -g status-left "#[fg=#d97757,bold] #S #[fg=#c1bfb5]| "

# Right side: battery, load/temp, memory, date and time
set -g status-right-length 130
set -g status-right "#(/Users/dasp/.config/tmux/battery.sh)#[fg=#c1bfb5] | #(/Users/dasp/.config/tmux/docker.sh)#[fg=#c1bfb5] | #(/Users/dasp/.config/tmux/system.sh) #[fg=#c1bfb5]| #(/Users/dasp/.config/tmux/memory.sh) #[fg=#c1bfb5]| %d.%m. %H:%M "

# Window status format
# Inactive windows: muted
# Pane count indicator: clay when multiple panes
set -g window-status-format "#[fg=#6c6a60] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d97757]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Active window: clay accent, bold
set -g window-status-current-format "#[fg=#d97757,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#d97757]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive: warm dark border
set -g pane-border-style "fg=#4a4940"
# Active: clay accent
set -g pane-active-border-style "fg=#d97757"

# Message colors
set -g message-style "bg=#2f2f2d,fg=#f5f4ef"

# Mode style (copy/scroll mode)
set -g mode-style "bg=#3a3a35,fg=#f5f4ef"
