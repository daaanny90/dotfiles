################################################################################
# TMUX THEME: iTerm2 Muted
# Matches the Neovim iterm2-dark-background colorscheme for consistency
################################################################################

# Status bar colors (same palette as Neovim theme)
# Background: bg_statusline, Foreground: fg
set -g status-style "bg=#141414,fg=#B8B8B8"

# Left side: session name (using cyan/info for accent)
set -g status-left-length 50
set -g status-left "#[fg=#6BA8A8,bold] #S #[fg=#B8B8B8]| "

# Right side: battery, load/temp, date and time
set -g status-right-length 130
set -g status-right "#(/Users/dasp/.config/tmux/battery.sh)#[fg=#B8B8B8] | #(/Users/dasp/.config/tmux/docker.sh)#[fg=#B8B8B8] | #(/Users/dasp/.config/tmux/system.sh) #[fg=#B8B8B8]| #(/Users/dasp/.config/tmux/memory.sh) #[fg=#B8B8B8]| %d.%m. %H:%M "

# Window status format
# Inactive windows: fg_gutter (muted)
# Pane count indicator: red/coral when multiple panes
set -g window-status-format "#[fg=#5A5A5A] #I:#W#{?#{>:#{window_panes},1}, #[fg=#B56A5A]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Active window: cyan/info, bold
set -g window-status-current-format "#[fg=#6BA8A8,bold] #I:#W#{?#{>:#{window_panes},1}, #[fg=#B56A5A]▪#{?#{==:#{window_panes},2},²,#{?#{==:#{window_panes},3},³,#{?#{==:#{window_panes},4},⁴,#{?#{==:#{window_panes},5},⁵,#{?#{==:#{window_panes},6},⁶,#{?#{==:#{window_panes},7},⁷,#{?#{==:#{window_panes},8},⁸,⁹}}}}}}},} "

# Pane border colors
# Inactive: border color
set -g pane-border-style "fg=#383838"
# Active: cyan/info
set -g pane-active-border-style "fg=#6BA8A8"

# Message colors
set -g message-style "bg=#1A1A1A,fg=#B8B8B8"

# Optional: mode style (copy/scroll mode) - use lavender for visibility
set -g mode-style "bg=#2A3540,fg=#B8B8B8"
