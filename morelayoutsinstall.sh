#!/bin/bash
# this is just because Sudo decided to not accept just running zenity for the password prompt in a way that I liked, aka I'm imcompetent as hell
export SUDO_ASKPASS=./zenitypass.sh


ask=`zenity --list --title="Installation Options" --column="0" "MacOS-Layout" "Ubuntu-Layout" --width=100 --height=300 --hide-header`

if [ "$ask" == "MacOS-Layout" ]; then
	sudo -A apt install gnome-shell-extension-zorin-dash gnome-shell-extension-zorin-hide-activities-move-clock -y
	echo "\n"
	echo '#############################'
	echo "\n" >> ~/.profile
	echo 'gnome-extensions enable zorin-dash@zorinos.com' >> ~/.profile
	echo 'awk -v n=2 'NR==FNR{total=NR;next} FNR==total-n+1{exit} 1' ~/.profile ~/.profile >> temp.txt && mv temp.txt ~/.profile'
	echo rm temp.txt
	echo '# Installed, log out and log back in to properly apply!'
fi

if [ "$ask" == "Ubuntu-Layout" ]; then
	sudo -A apt install gnome-shell-extension-zorin-dash
# 	sudo -A mv
fi
exit 0
