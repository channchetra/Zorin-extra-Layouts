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

gui () {
ask=$(zenity --list --title="Installation Options" --column="0" "MacOS-Layout" "Ubuntu-Layout" "Windows Classic-Layout" "Windows 11-Layout" "Pop-Shell (BETA)" "Misc." --width=100 --height=300 --hide-header)
	if [ "$ask" == "MacOS-Layout" ]; then
		echo -e "${red}Make sure to fill in your password in the Terminal! there is no popup.${reset}"
		sudo apt install gnome-shell-extension-zorin-dash gnome-shell-extension-zorin-hide-activities-move-clock -y
		restart_gnome
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
		restart_gnome
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
		restart_gnome
		gnome-extensions enable pop-shell@system76.com -q
		echo -e "${red}The Keybinds can be reset in settings > keybinds!${reset}"
		exit
	fi

	if [ "$ask" == "Misc." ]; then ask2=$(zenity --list --title="Installation Options" --column="0" "Install No Annoyance" "Install Tiling Assistant" "Install Caffeine" "Install BlurMyShell" "Install Just Perfection" "Unity Layout (BETA)" --width=100 --height=300 --hide-header)
		if [ "$ask2" == "Install No Annoyance" ]; then 
			echo -e "${green}Downloading extension...${reset}"
			sudo apt install gnome-shell-extension-no-annoyance
			restart_gnome
			gnome-extensions enable noannoyance@sindex.com -q
		fi

		if [ "$ask2" == "Install Tiling Assistant" ];then
			echo -e "${green}Downloading Extension...${reset}"
			wget https://extensions.gnome.org/extension-data/tiling-assistantleleat-on-github.v23.shell-extension.zip
			unzip tiling-assistantleleat-on-github.v23.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/tiling-assistant@leleat-on-github/
			restart_gnome
			gnome-extensions enable tiling-assistant@leleat-on-github
			echo -e "${green}all done!${reset}"
		fi

		if [ "$ask2" == "Install Caffeine" ]; then
			echo -e "${green}Downloading extension...${reset}"
			wget https://extensions.gnome.org/extension-data/caffeinepatapon.info.v37.shell-extension.zip
			unzip caffeinepatapon.info.v37.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/caffeine@patapon.info/
			restart_gnome
			gnome-extensions enable caffeine@patapon.info
			echo -e "${green}all done!${reset}"
		fi

		if [ "$ask2" == "Install Just Perfection" ]; then
			echo -e "${green}Downloading extension...${reset}"
			wget https://extensions.gnome.org/extension-data/just-perfection-desktopjust-perfection.v16.shell-extension.zip
			unzip just-perfection-desktopjust-perfection.v16.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/
			restart_gnome
			gnome-extensions enable just-perfection-desktop@just-perfection
			echo -e "${green}all done!${reset}"
		fi

		if [ "$ask2" == "Install BlurMyShell" ]; then
			echo -e "${green}Downloading extension...${reset}"
			wget https://extensions.gnome.org/extension-data/blur-my-shellaunetx.v22.shell-extension.zip
			unzip blur-my-shellaunetx.v22.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/blur-my-shell@aunetx/
			restart_gnome
			gnome-extensions enable blur-my-shell@aunetx
			echo -e "${green}all done!${reset}"
		fi

		if [ "$ask2" == "Unity Layout (BETA)" ]; then
			echo -e "${green}Downloading extension...${reset}"
			wget https://extensions.gnome.org/extension-data/unitehardpixel.eu.v59.shell-extension.zip
			unzip unitehardpixel.eu.v59.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/
			restart_gnome
			gnome-extensions disable zorin-dash@zorinos.com
			gnome-extensions disable zorin-menu@zorinos.com
			gnome-extensions disable zorin-taskbar@zorinos.com
			gnome-extensions enable unite@hardpixel.eu
			echo -e "${green}all done!${reset}"
		fi
	else
		echo -e "${red}Zenity not found or something else went wrong! run sudo apt install zenity first and try again!${reset}"
		exit 0
	fi
}

bigtext () {
	if [ "$(ls /usr/bin/figlet 2> /dev/null)" == "/usr/bin/figlet" ]; then
		figlet "Zorin Tweaks"
	else
		echo -e "${bold}Zorin Tweaks${reset}"
	fi
}

restart_gnome () {
	if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
	echo -e "${red}Wayland won't restart GNOME by default, please logout and enable the extensions yourself using the GNOME Extensions app!${reset}"
	elif [ "$XDG_SESSION_TYPE" == "x11" ]; then
	echo -e "${green}restarting GNOME...${reset}"
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting...")'
	sleep 5s
	echo -e "${green}GNOME restarted!${reset}"
	else echo -e "${red}XDG_SESSION_TYPE isn't Wayland or X11...huh?${reset}"
	fi
}

help () {
	bigtext
   	echo "This script allows to set different Layouts on Zorin OS 16, as well as applying some other tweaks."
   	echo -e "${reset}------------"
   	echo -e "${blue}${bold}${uline}Syntax${reset}: $0 [Options]"
   	echo ""
   	echo -e "${blue}${bold}${uline}Available options:${reset}"
   	echo -e "$0 -h   |   ${green}shows a help page for this script${reset}"
   	echo -e "$0 -g   |   ${green}shows a GUI to do different actions${reset}"
   	echo -e "$0 -mac |   ${green}sets the macOS-like Layout${reset}"
	echo -e "$0 -11  |   ${green}sets the Windows 11-like Layout${reset}"
	echo -e "$0 -cl  |   ${green}sets the Windows-Classic-Like Layout${reset}"
	echo -e "$0 -ub  |   ${green}sets the Ubuntu Layout${reset}"
   	echo "------------"
   	exit
}

macOS() {
	sudo apt install gnome-shell-extension-zorin-dash gnome-shell-extension-zorin-hide-activities-move-clock -y
	restart_gnome
	gnome-extensions disable zorin-menu@zorinos.com
	gnome-extensions disable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-dash@zorinos.com
	gnome-extensions enable zorin-hide-activities-move-clock@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
}

winclassic() {
	echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
	gnome-extensions disable zorin-dash@zorinos.com
	gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
	gnome-extensions enable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-menu@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
}

ubuntu() {
	sudo apt install gnome-shell-extension-zorin-dash -y
	echo -e "${green}Gnome will be restarted in 5 seconds...${reset}"
	sleep 5s
	restart_gnome
	gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
	gnome-extensions disable zorin-menu@zorinos.com
	gnome-extensions disable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-dash@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/ubuntu-zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
}

win11() {
	echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
	gnome-extensions disable zorin-dash@zorinos.com
	gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
	gnome-extensions enable zorin-taskbar@zorinos.com
	gnome-extensions enable zorin-menu@zorinos.com
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
	curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
}

popshell() {
	echo -e "${red} heavily in-Beta, might not work as expected${reset}"
	echo -e "${red}THIS REPLACES GNOME DEFAULT KEYBOARD SHORTCUTS${reset}"
	read -r -p "Press [Enter] to continue, or [CTRL + C] to cancel."
	sudo apt install node-typescript -y
	mkdir ~/.popshell
	cd ~/.popshell || exit
	git clone https://github.com/pop-os/shell.git 
	cd shell || exit
	make local-install
	restart_gnome
	gnome-extensions enable pop-shell@system76.com -q
	echo -e "${red}The Keybinds can be reset in settings > keybinds!${reset}"
	exit
}

if [ -n "$1" ]; then
   case "$1" in
   	-h)
      	help 
      	;;
   	-g)
      	gui
      	;;
	-mac)
		macOS
		;;
	-ub)
		ubuntu
		;;
	-11)
		win11
		;;
	-cl)
		winclassic
		;;
	-ps)
		popshell
		;;
   	*)
      	echo "$1 is not an option"
      	;;
   esac
   shift
else
   bigtext
fi

#	if [ "$(ls /usr/bin/zenity)" == "/usr/bin/zenity" ]; then
#		ask=$(zenity --list --title="Installation Options" --column="0" "MacOS-Layout" "Ubuntu-Layout" "Windows Classic-Layout" "Windows 11-Layout" "Pop-Shell (BETA)" "Misc." "Show Info" --width=100 --height=300 --hide-header)
#		if [ "$ask" == "MacOS-Layout" ]; then
#			echo -e "${red}Make sure to fill in your password in the Terminal! there is no popup.${reset}"
#			sudo apt install gnome-shell-extension-zorin-dash gnome-shell-extension-zorin-hide-activities-move-clock -y
#			restart_gnome
#			gnome-extensions disable zorin-menu@zorinos.com
#			gnome-extensions disable zorin-taskbar@zorinos.com
#			gnome-extensions enable zorin-dash@zorinos.com
#			gnome-extensions enable zorin-hide-activities-move-clock@zorinos.com
#			curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
#		fi
#	
#		if [ "$ask" == "Ubuntu-Layout" ]; then
#			echo -e "${red}Make sure to fill in your password in the Terminal! there is no popup.${reset}"
#			sudo apt install gnome-shell-extension-zorin-dash -y
#			echo -e "${green}Gnome will be restarted in 5 seconds...${reset}"
#			restart_gnome
#			gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
#			gnome-extensions disable zorin-menu@zorinos.com
#			gnome-extensions disable zorin-taskbar@zorinos.com
#			gnome-extensions enable zorin-dash@zorinos.com
#			curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/ubuntu-zorin-dash-conf | dconf load /org/gnome/shell/extensions/zorin-dash/
#		fi
#	
#		if [ "$ask" == "Windows Classic-Layout" ]; then
#			echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
#			gnome-extensions disable zorin-dash@zorinos.com
#			gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
#			gnome-extensions enable zorin-taskbar@zorinos.com
#			gnome-extensions enable zorin-menu@zorinos.com
#			curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
#			curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/classic-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
#		fi
#	
#		if [ "$ask" == "Windows 11-Layout" ]; then
#			echo -e "${red}Note that Gnome won't be restarted for this layout.${reset}"
#			gnome-extensions disable zorin-dash@zorinos.com
#			gnome-extensions disable zorin-hide-activities-move-clock@zorinos.com
#			gnome-extensions enable zorin-taskbar@zorinos.com
#			gnome-extensions enable zorin-menu@zorinos.com
#			curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-panel-conf | dconf load /org/gnome/shell/extensions/zorin-taskbar/
#			curl https://raw.githubusercontent.com/TGRush/Zorin-extra-Layouts/main/11-menu-conf | dconf load /org/gnome/shell/extensions/zorin-menu/
#		fi
#	
#		if [ "$ask" == "Pop-Shell (BETA)" ]; then
#			echo -e "${red} heavily in-Beta, might not work as expected${reset}"
#			echo -e "${red}THIS REPLACES GNOME DEFAULT KEYBOARD SHORTCUTS${reset}"
#			read -r -p "Press [Enter] to continue, or [CTRL + C] to cancel."
#			sudo apt install node-typescript -y
#			mkdir ~/.popshell
#			cd ~/.popshell || exit
#			git clone https://github.com/pop-os/shell.git 
#			cd shell || exit
#			make local-install
#			restart_gnome
#			gnome-extensions enable pop-shell@system76.com -q
#			echo -e "${red}The Keybinds can be reset in settings > keybinds!${reset}"
#			exit
#		fi
#	
#		if [ "$ask" == "Show Info" ]; then
#			echo -e "${red}${bold}${uline}Zorin-extra-Layouts${reset}"
#			echo -e "${green}${uline}A script to install extra layouts and other desktop tweaks on Zorin OS 16 Core${reset}"
#			echo "--------"
#			echo "To use the script, simply run the command from the GitHub page and select your layout, the rest is entirely automated."
#			echo "If you want to fork/modify this product, then be sure to read the license as well!"
#		fi
#	
#		if [ "$ask" == "Misc." ]; then ask2=$(zenity --list --title="Installation Options" --column="0" "Install No Annoyance" "Install Tiling Assistant" "Install Caffeine" "Install BlurMyShell" "Install Just Perfection" "Unity Layout (BETA)" --width=100 --height=300 --hide-header)
#			if [ "$ask2" == "Install No Annoyance" ]; then 
#				echo -e "${green}Downloading extension...${reset}"
#				sudo apt install gnome-shell-extension-no-annoyance
#				restart_gnome
#				gnome-extensions enable noannoyance@sindex.com -q
#			fi
#	
#			if [ "$ask2" == "Install Tiling Assistant" ];then
#				echo -e "${green}Downloading Extension...${reset}"
#				wget https://extensions.gnome.org/extension-data/tiling-assistantleleat-on-github.v23.shell-extension.zip
#				unzip tiling-assistantleleat-on-github.v23.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/tiling-assistant@leleat-on-github/
#				restart_gnome
#				gnome-extensions enable tiling-assistant@leleat-on-github
#				echo -e "${green}all done!${reset}"
#			fi
#	
#			if [ "$ask2" == "Install Caffeine" ]; then
#				echo -e "${green}Downloading extension...${reset}"
#				wget https://extensions.gnome.org/extension-data/caffeinepatapon.info.v37.shell-extension.zip
#				unzip caffeinepatapon.info.v37.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/caffeine@patapon.info/
#				restart_gnome
#				gnome-extensions enable caffeine@patapon.info
#				echo -e "${green}all done!${reset}"
#			fi
#	
#			if [ "$ask2" == "Install Just Perfection" ]; then
#				echo -e "${green}Downloading extension...${reset}"
#				wget https://extensions.gnome.org/extension-data/just-perfection-desktopjust-perfection.v16.shell-extension.zip
#				unzip just-perfection-desktopjust-perfection.v16.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection/
#				restart_gnome
#				gnome-extensions enable just-perfection-desktop@just-perfection
#				echo -e "${green}all done!${reset}"
#			fi
#	
#			if [ "$ask2" == "Install BlurMyShell" ]; then
#				echo -e "${green}Downloading extension...${reset}"
#				wget https://extensions.gnome.org/extension-data/blur-my-shellaunetx.v22.shell-extension.zip
#				unzip blur-my-shellaunetx.v22.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/blur-my-shell@aunetx/
#				restart_gnome
#				gnome-extensions enable blur-my-shell@aunetx
#				echo -e "${green}all done!${reset}"
#			fi
#	
#			if [ "$ask2" == "Unity Layout (BETA)" ]; then
#				echo -e "${green}Downloading extension...${reset}"
#				wget https://extensions.gnome.org/extension-data/unitehardpixel.eu.v59.shell-extension.zip
#				unzip unitehardpixel.eu.v59.shell-extension.zip -d ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu/
#				restart_gnome
#				gnome-extensions disable zorin-dash@zorinos.com
#				gnome-extensions disable zorin-menu@zorinos.com
#				gnome-extensions disable zorin-taskbar@zorinos.com
#				gnome-extensions enable unite@hardpixel.eu
#				echo -e "${green}all done!${reset}"
#			fi
#	else
#		echo -e "${red}Zenity not found or something else went wrong! run sudo apt install zenity first and try again!${reset}"
#		exit 0
#	fi
#	fi
#	