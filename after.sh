#!/bin/bash
# Dorian is Quick installator for Ubuntu
# Author : Sherlock3721
#
# Thank you for using Dorian!

tabs 4
clear

# Check if whiptail is installed
function WhiptailCheck {
	if (command -v whiptail 2>&1 >/dev/null); then
		whiptail --msgbox "Dorian v0.2 by Sherlock3721" 10 100
		UserPrivileges
	else
		apt-get install whiptail
	fi
}

# User privileges check
function UserPrivileges {
	if [[ $EUID != 0 ]]; then
		if [[ $(groups $USER | grep -q 'sudo'; echo $?) != 0 ]]; then
			echo "This user account doesn't have admin privileges."
			echo "Log in as a user with admin privileges to be able to much of these scripts.."
			echo "Exiting..."
			sleep 5 && exit 99
		else
			main
		fi
	else
		# if dependency whiptail is installed
		if command -v whiptail 2>&1 >/dev/null; then
			# draw window
			if (whiptail --title "Root User" --yesno "You are logged in as the root user. This is not recommended.\n\nAre you sure you want to proceed?" 12 56) then
				echo "You are logged in as the root user. This is not recommended. :/"
			else
				echo "Exiting..."
				exit 99
			fi
		else
			echo "You are logged in as the root user. This is not recommended. :/"
			read -p "Are you sure you want to proceed? [y/N] " REPLY
			REPLY=${REPLY:-n}
			case $REPLY in
			[Yy]* )
				echo"Proceeding..."
				;;
			[Nn]* )
				echo"Exiting..."
				exit 99
				;;
			* )
				echo'Sorry, try again.' && UserPrivileges
				;;
			esac
		fi
	fi
}

# System check
function main {
	if lsb_release -ds | grep -qE '(Ubuntu)'; then	# Check if is OS supported
		SystemOS="Ubuntu"
		SystemCheck=$(hostnamectl | grep Chassis: | cut -d' ' -f13) # Automatic Check if is server or desktop
		if [[ "$SystemCheck" == "server" ]]; then
			Server
		elif [[ "$SystemCheck" == "laptop" ||  $SystemCheck == "desktop" ]]; then
			Desktop
		else	# Manual select server or Desktop
			OSChoice=$(whiptail --title "SORRY, WE DIDN'T IDENTIFY YOUR MACHINE!" --menu "PLEASE CHOICE DEVICE WHAT YOU USING" 18 100 10 \
		  1 "Desktop (PC/laptop)" \
		  2 "Server" 3>&1 1>&2 2>&3)

			if [[ $CHOICE == 1 ]]; then
				Desktop
		  elif [[ $CHOICE == 2 ]]; then
				Server
		  fi
		fi
	else
		SystemOS=$(lsb_release -ds & echo "NOT SUPPORTED")
		if whiptail --yesno "Your System" $SystemOS "is not supported, do you want procced?" 10 100 --defaultno; then
			OSChoice=$(whiptail --title "SORRY, WE DIDN'T IDENTIFY YOUR MACHINE!" --menu "PLEASE CHOICE DEVICE WHAT YOU USING" 18 100 10 \
		  1 "Desktop (PC/laptop)" \
		  2 "Server" 3>&1 1>&2 2>&3)

			if [[ $CHOICE == 1 ]]; then
				Desktop
		  elif [[ $CHOICE == 2 ]]; then
				Server
		  fi
		else
		  exit 99
		fi
	fi
}

function Desktop {
	CHOICE=$(whiptail --menu Desktop 18 100 10 \
  1 "Install all recommended software recommended" \
  2 "Choose software what you want install" 3>&1 1>&2 2>&3)

  if [[ $CHOICE == 1 ]]; then
    DesktopAll
  elif [[ $CHOICE == 2 ]]; then
    DesktopSelect
  fi
}

function Server {
	CHOICE=$(whiptail --menu Desktop 18 100 10 \
  1 "Install all recommended software recommended" \
  2 "Choose software what you want install" 3>&1 1>&2 2>&3)

  if [[ $CHOICE == 1 ]]; then
    ServerAll
  elif [[ $CHOICE == 2 ]]; then
    ServerSelect
  fi
}

function DesktopSelect {
	CHOICES=$(whiptail --separate-output --checklist "Choose options" 10 35 5 \
	"1" "Steam" OFF \
	"2" "Python3" ON \
	"3" "ffmpeg" ON \
	"4" "Snap" ON \
	"5" "Curl" ON \
	"6" "OBS" OFF \
	"7" "Replace Nautilus with Nemo" ON \
	"8" "Add Nemo addon for media info" ON \
	"9" "Add new theme" OFF \
	"10" "VLC" ON \
	"11" "WINE" ON \
	"12" "Blender" ON \
	"13" "Git" ON \
	"14" "Make" ON \
	"15" "GCC" ON \
	"16" "Spotify" OFF \
	"16" "Discord" OFF \
	"17" "Droidcam" OFF \
	 3>&1 1>&2 2>&3)

	if [ -z "$CHOICE" ]; then
	echo "No option was selected (user hit Cancel or unselected all options)"
	else
	for CHOICE in $CHOICES; do
		case "$CHOICE" in
		"1")
			apt-get install steam -y
			;;
		"2")
			apt-get install python3 -y
			;;
		"3")
			apt-get install ffmpeg -y
			;;
		"4")
			apt-get install snap -y
			;;
		"5")
			apt-get install curl -y
			;;
		"6")
			snap install obs
			;;
		"7")
			apt-get install nemo -y
			xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
			gsettings set org.gnome.desktop.background show-desktop-icons false
			apt-get remove nautilus -y
			apt-get purge nautilus -y
			;;
		"8")
			apt-get install mediainfo
			wget https://github.com/linux-man/nemo-mediainfo-tab/releases/download/v1.0.3/nemo-mediainfo-tab_1.0.3_all.deb # Link aktualizovat
			sudo dpkg -i nemo-mediainfo-tab_1.0.3_all.deb -y
			rm nemo-mediainfo-tab_1.0.3_all.deb
			;;
		"9")
			add-apt-repository -y ppa:papirus/papirus
			apt-get install papirus-icon-theme -y
			gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"
			gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
			;;
		"10")
			apt-get install vlc -y
			;;
		"11")
			apt-get install wine -y
			;;
		"12")
			apt-get install blender -y
			;;
		"13")
			apt-get install git -y
			;;
		"14")
			apt-get install make -y
			;;
		"15")
			apt-get install gcc -y
			;;
		"16")
			curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | apt-key add -
			apt-get update
			apt-get install spotify-client -y

			cd
			git clone https://github.com/abba23/spotify-adblock-linux.git
			cd spotify-adblock-linux
			wget -O cef.tar.bz2 https://cef-builds.spotifycdn.com/cef_binary_88.1.6%2Bg4fe33a1%2Bchromium-88.0.4324.96_linux64_minimal.tar.bz2
			tar -xf cef.tar.bz2 --wildcards '*/include' --strip-components=1
			make
			sudo make install
			echo spotify-adblock-linux >> ~/.hidden
			cd
			sudo echo "[Desktop Entry]
					Type=Application
					Name=Spotify (adblock)
					GenericName=Music Player
					Icon=spotify-client
					TryExec=spotify
					Exec=env LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify %U
					Terminal=false
					MimeType=x-scheme-handler/spotify;
					Categories=Audio;Music;Player;AudioVideo;
					StartupWMClass=spotify" > .local/share/applications/Spotify.desktop
			;;
		"17")
			snap install discord
			;;
		"18")
			apt-get install v4l2loopback-utils v4l2loopback-dkms cmake nasm yasm pkg-config libgtk2.0-dev
			modprobe v4l2loopback
			cd /tmp/
			wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.2.zip
			unzip droidcam_latest.zip -d droidcam
			cd droidcam
			sudo ./install-client
			cd
			;;
		*)
			echo "Unsupported item $CHOICE!" >&2
			exit 1
			;;
		esac
	done
	fi
}

WhiptailCheck # code start here

<<RRR

  	echo -e "${RED}Hide snap folder${NC}"
  	echo snap >> ~/.hidden

  	echo -e "${RED}Install Gnome Tweak${NC}"
  	sudo apt-get install gnome-tweak-tool -y

  	echo -e "${RED}Install torrent${NC}"
  	sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
  	sudo apt-get update
  	sudo apt-get install qbittorrent -y

  	echo -e "${RED}Install ulauncher${NC}"
  	wget https://github.com/Ulauncher/Ulauncher/releases/download/5.10.0/ulauncher_5.10.0_all.deb
  	sudo dpkg -i ulauncher_5.10.0_all.deb
  	echo -e "${RED}Fix broken${NC}"
  	sudo apt-get --fix-broken install -y

  	echo -e "${RED}Dynamic Wallpaper${NC}"
  	sudo apt-get install wallch -y

  	echo -e "${RED}Backup & Restore${NC}"
  	sudo apt-get install timeshift -y

  	echo -e "${RED}Sync with Phone${NC}"
  	sudo apt-get install kdeconnect -y

  	echo -e "${RED}Hide Disks on Dock${NC}"
  	gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false

  	echo -e "${RED}Lutris${NC}"
  	sudo add-apt-repository ppa:lutris-team/lutris
  	sudo apt-get update
  	sudo apt-get install lutris

		echo -e "${RED}Android Debug Tools${NC}"
  	sudo apt-get install adb
  	sudo apt-get install fastboot

		echo -e "${RED}Samba${NC}"
  	sudo apt-get install samba

		echo -e "${RED}Galery${NC}"
  	sudo apt-get install shotwell

		echo -e "${RED}Terminal${NC}"
  	sudo apt-get install deepin-terminal

		echo -e "${RED}Net Tools${NC}"
  	sudo apt install net-tools

		echo -e "${RED}Install CUDA Driver${NC}"
		wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
		mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
		apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
		add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
		apt-get update
		apt-get -y install cuda

  	echo -e "${RED}Recomended software${NC}"
  	firefox https://www.blackmagicdesign.com/products/davinciresolve/

  else
  	echo -e "${RED}Installing dependencies...${NC}"
  	sudo apt install curl gnupg2 ca-certificates lsb-release -y
  	sudo apt install snapd -y
  	sudo snap install core
  	sudo snap refresh core

  	echo -e "${RED}Replacing UFW with Firewalld...${NC}"
  	sudo apt install firewalld
  	sudo systemctl start firewalld
  	sudo systemctl enable firewalld
  	sudo systemctl stop ufw
  	sudo systemctl disable ufw
  	sudo apt remove ufw -y

  	echo -e "${RED}Replacing Networkd with Network manager...${NC}"
  	sudo apt install network-manager
  	sudo nano /etc/netplan/00-installer-config.yaml || sudo nano /etc/netplan/00*.yaml
  	sudo sed -i 's/networkd/NetworkManager/g' /etc/netplan/00*.yaml
  	sudo systemctl enable network-manager.service
  	sudo systemctl disable systemd-networkd.service

  	echo -e "${RED}Malware finder...${NC}"
  	sudo apt install rkhunter -y
  	sudo apt install chkrootkit -y

  	echo -e "${RED}Remove certbot from apt...${NC}"
  	sudo apt-get remove certbot -y

  	echo -e "${RED}Installing certbot from snap...${NC}"
  	#sudo apt install nginx
  	sudo snap install --classic certbot
  	sudo ln -s /snap/bin/certbot /usr/bin/certbot

  	echo -e "${RED}Installing cockpit...${NC}"
  	sudo apt-get install cockpit

  	echo -e "${RED}Installing PHP...${NC}"
  	sudo apt-get install php

  	echo -e "${RED}Installing Lynis...${NC}"
  	sudo apt-get install lynis

  	sudo apt install git build-essential
  	sudo apt install openjdk-11-jre-headless
  	sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft

		// echo to ~/.bashrc
		alias df='df -h -x squashfs -x tmpfs -x devtmpfs'
		alias fdsk="sudo fdisk -l | sed -e '/Disk \/dev\/loop/,+5d'"

		crontab -e
		@reboot firewall-cmd --reload
		@daily apt-get update && apt-get upgrade -y

  	echo -e "${RED}sudo certbot --nginx${NC}"
  fi
	echo -e "${RED}Done!${NC}"
else

fi
RRR
