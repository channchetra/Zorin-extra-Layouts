#!/bin/bash

# Ansi color code variables
# shellcheck disable=SC2034
red="\e[0;91m"
# shellcheck disable=SC2034
blue="\e[0;94m"
# shellcheck disable=SC2034
green="\e[0;92m"
# shellcheck disable=SC2034
white="\e[0;97m"
# shellcheck disable=SC2034
bold="\e[1m"
# shellcheck disable=SC2034
uline="\e[4m"
# shellcheck disable=SC2034
reset="\e[0m"

# this is just because Sudo decided to not accept just running zenity for the password prompt in a way that I liked, aka I'm imcompetent as hell

if [ $(ls /usr/bin/zenity) == "/usr/bin/zenity" ]
then
ask=$(zenity --list --title="Installation Options" --column="0" "MacOS-Layout" "Ubuntu-Layout" --width=100 --height=300 --hide-header)
if [ "$ask" == "MacOS-Layout" ]; then
	
	sudo apt install gnome-shell-extension-zorin-dash gnome-shell-extension-zorin-hide-activities-move-clock -y
	echo -e "${green}Gnome will be restarted in 5 seconds...${reset}"
	sleep 5s
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
	echo "waiting 10s..."
	sleep 10s
	gnome-extensions disable zorin-menu@zorinos.com
	gnome-extensions disable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-dash@zorinos.com
	gnome-extensions enable zorin-hide-activities-move-clock@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
fi

if [ "$ask" == "Ubuntu-Layout" ]; then
	echo -e "${red}Make sure to fill in your password in the Terminal! there is no popup.${reset}"
	sudo apt install gnome-shell-extension-zorin-dash -y
	echo -e "${green}Gnome will be restarted in 5 seconds...${reset}"
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting...")'
	echo "waiting 10s..."
	sleep 10s
	gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
	gnome-extensions disable zorin-menu@zorinos.com
	gnome-extensions disable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-dash@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/ubuntu-zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
fi
else
echo -e "${red}Zenity not found! run sudo apt install zenity first!${reset}"
exit 0
fi