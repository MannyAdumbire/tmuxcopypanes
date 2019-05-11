#!/bin/bash

# This will use the default session as target unless it is specified with the '-t' flag
for window in $(tmux list-windows -a -F "#{window_id}")
do 
	tmux list-panes -t $window -F '#{window_name} #{pane_current_path} #{pane_current_command} #{window_layout}'
done
