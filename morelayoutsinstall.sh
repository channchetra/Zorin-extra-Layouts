#!/bin/bash

clear

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

if [ "$(ls /usr/bin/zenity)" == "/usr/bin/zenity" ]; then
	ask=$(zenity --list --title="Installation Options" --column="0" "MacOS-Layout" "Ubuntu-Layout" "Windows Classic-Layout" "Windows 11-Layout" "Pop-Shell (BETA)" "Install No Annoyance" "Show Info" --width=100 --height=300 --hide-header)
	if [ "$ask" == "MacOS-Layout" ]; then
		echo -e "${red}Make sure to fill in your password in the Terminal! there is no popup.${reset}"
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

	if [ "$ask" == "Windows Classic-Layout" ]; then
		echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
		gnome-extensions disable zorin-dash@zorinos.com
		gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
		gnome-extensions enable zorin-taskbar@zorinos.com
		gnome-extensions enable zorin-menu@zorinos.com
		curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
		curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
	fi

	if [ "$ask" == "Windows 11-Layout" ]; then
		echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
		gnome-extensions disable zorin-dash@zorinos.com
		gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
		gnome-extensions enable zorin-taskbar@zorinos.com
		gnome-extensions enable zorin-menu@zorinos.com
		curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
		curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
	fi

	if [ "$ask" == "Pop-Shell (BETA)" ]; then
		echo -e "${red} heavily in-Beta, might not work as expected${reset}"
		echo -e "${red}THIS REPLACES GNOME DEFAULT KEYBOARD SHORTCUTS${reset}"
		read -r -p "Press [Enter] to continue, or [CTRL + C] to cancel."
		sudo apt install node-typescript -y
		mkdir ~/.popshell
		cd ~/.popshell || exit
		git clone https://github.com/pop-os/shell.git 
		cd shell || exit
		make local-install
		busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting...")'
		sleep 5s
		gnome-extensions enable pop-shell@system76.com -q
		echo -e "${red}The Keybinds can be reset in settings > keybinds!${reset}"
		exit
	fi

	if [ "$ask" == "Show Info" ]; then
		echo -e "${red}${bold}${uline}Zorin-extra-Layouts${reset}"
		echo -e "${green}${uline}A script to install extra layouts and other desktop tweaks on Zorin OS 16 Core${reset}"
		echo "--------"
		echo "To use the script, simply run the command from the GitHub page and select your layout, the rest is entirely automated."
		echo "If you want to fork/modify this product, then be sure to read the license as well!"
	fi

	if [ "$ask" == "Install No Annoyance" ]; then 
		echo -e "${red}}Make sure to fill in your password in the Terminal! there is no popup.${reset}"
		echo -e "${green}${uline}No Annoyance${reset}"
		echo -e "${green}removes GNOME »Window is ready« notifications${reset}"
		read -r -p "To continue the installation, hit [ENTER], to cancel, hit [CTRL+C]"
		sudo apt install gnome-shell-extension-no-annoyance
		busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting...")'
		gnome-extensions enable noannoyance@sindex.com -q
	fi
else

	echo -e "${red}Zenity not found or something else went wrong! run sudo apt install zenity first and try again!${reset}"
	exit 0
fi
