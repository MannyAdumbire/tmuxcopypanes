#!/bin/bash

#The the first command line argument to this script will be passed to the tmux '-t' flag as the target session 

IFS=$'\n'

[[ $1 ]] && TARGET_SESSION=$1 || TARGET_SESSION=0 



for window in $(tmux list-windows  -F  "#{window_id} #{window_name} #{window_layout}" -t $TARGET_SESSION)
do 
				windowid=$(cut -d " " -f 1 <<< $window)
				windowname=$(cut -d " " -f 2 <<< $window)
				echo -e "\t-"$windowname":"	
				echo -e "\t\tlayout: "$(cut -d " " -f 3 <<< $window)
				echo -e "\t\tpanes:"
					
				for pane in $(tmux list-panes -t $TARGET_SESSION:$windowid -F '#{pane_current_path} #{pane_current_command}')
				do
								
								echo -e "\t\t\t-cd $(awk "{print $1}"<<< $pane)"
								echo -e "\t\t\t-$(awk "{print $2}" <<< $pane)"
				done
done
