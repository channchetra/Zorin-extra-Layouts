#!/bin/bash

### This script is highly experimental at the moment, don't expect much out of it.

restart_gnome () {
	if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
	echo -e "${red}Wayland won't restart GNOME by default, please logout and enable the extensions yourself using the GNOME Extensions app!"
	elif [ "$XDG_SESSION_TYPE" == "x11" ]; then
	echo -e "${green}restarting GNOME...${reset}"
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting...")'
	sleep 5s
	echo -e "${green}GNOME restarted!${reset}"
	fi
}

if [ "$ask" == "macos" ]; then
	sudo apt install gnome-shell-extension-zorin-dash gnome-shell-extension-zorin-hide-activities-move-clock -y
	restart_gnome
	gnome-extensions disable zorin-menu@zorinos.com
	gnome-extensions disable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-dash@zorinos.com
	gnome-extensions enable zorin-hide-activities-move-clock@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
fi

if [ "$ask" == "win11" ]; then
    echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
	gnome-extensions disable zorin-dash@zorinos.com
	gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
	gnome-extensions enable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-menu@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
fi

if [ "$ask" == "ubuntu"]; then
	sudo apt install gnome-shell-extension-zorin-dash -y
	echo -e "${green}Gnome will be restarted in 5 seconds...${reset}"
	restart_gnome
	gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
	gnome-extensions disable zorin-menu@zorinos.com
	gnome-extensions disable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-dash@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/ubuntu-zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
fi

if [ "$ask" == "winclassic" ]; then
    echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
	gnome-extensions disable zorin-dash@zorinos.com
	gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
	gnome-extensions enable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-menu@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
fi

if [ "$ask" == "popshell" ]; then
