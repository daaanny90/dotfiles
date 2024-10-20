#!/usr/bin/env zsh

###### DESIGN TWEAKS ######
run "./tokyio_night_palette.sh"
# Refresh status line every 5 seconds - Good for when music is playing / update time etc
set -g status-interval 5

# Start window and pane indices at 1.
tmux set -g base-index 1
tmux set -g pane-base-index 0

# Length of tmux status line
tmux set -g status-left-length 30
tmux set -g status-right-length 150

tmux set-option -g status "on"

# Default statusbar color
# tmux set-option -g status-style "bg=${PALLETE[bg_highlight]},fg=${PALLETE[white]}" # bg=bg1, fg=fg1

# Default window title colors
# tmux set-window-option -g window-status-style bg=colour214,fg=colour237 # bg=yellow, fg=bg1

# Default window with an activity alert
# tmux set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3

# Active window title colors
# tmux set-window-option -g window-status-current-style 'bg=${PALETTE[bg_highlight]},fg=${PALETTE[white]}' # fg=bg2

# Set active pane border color
# tmux set-option -g pane-active-border-style fg=colour214

# Set inactive pane border color
# tmux set-option -g pane-border-style fg=colour239

# Message info
# tmux set-option -g message-style bg=colour239,fg=colour223 # bg=bg2, fg=fg1

# Writing commands inactive
# tmux set-option -g message-command-style bg=colour239,fg=colour223 # bg=fg3, fg=bg1
# Length of tmux status line
tmux set -g status-left-length 30
tmux set -g status-right-length 150

tmux set-option -g status "on"

tmux set-option -g status-left "\
#[fg=colour7, bg=colour241]#{?client_prefix,#[bg=colour167],} ❐ #S \
#[fg=colour241, bg=colour237]#{?client_prefix,#[fg=colour167],}#{?window_zoomed_flag, 🔍,}"

tmux set-option -g status-right "\
#[fg=colour214, bg=colour237] \
#[fg=colour237, bg=colour214] ♥ #(~/.config/tmux/scripts/battery.sh) \
#[fg=colour246, bg=colour237] %b %d '%y\
#[fg=colour109]  %H:%M \
#[fg=colour248, bg=colour239]"

tmux set-window-option -g window-status-current-format "\
#[fg=colour237, bg=colour214]\
#[fg=colour239, bg=colour214] #I* \
#[fg=colour239, bg=colour214, bold] #W \
#[fg=colour214, bg=colour237]"

tmux set-window-option -g window-status-format "\
#[fg=colour237,bg=colour239,noitalics]\
#[fg=colour223,bg=colour239] #I \
#[fg=colour223, bg=colour239] #W \
#[fg=colour239, bg=colour237]"

tmux setw -g window-status-bell-style 'fg=colour2 bg=colour1 bold'

# messages
tmux set -g message-style 'fg=colour2 bg=colour0 bold'
