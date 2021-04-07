#!/bin/bash
# Dorian is Quick installator for Ubuntu
# Author : Sherlock3721
#
# Thank you for using Dorian!

#Declaration 
tabs 4
clear

TITLE="Ubuntu Post-Install Script"
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m'

# Start Program
echo -e "${RED}Dorian v0.1 by Sherlock3721${NC}"
echo ""
echo -e "${RED}!!! Warning if you press key you agree with eula !!! ${NC}"
read -r -p "Do you accept EULA? [y/N] " response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then

read -r -p "Is PC? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo -e "${RED}Install Steam${NC}"
	sudo apt-get install steam -y > /dev/null

	echo -e "${RED}Install Python3${NC}"
	sudo apt-get install python3 -y > /dev/null

	echo -e "${RED}Install FFmpeg${NC}"
	sudo apt-get install ffmpeg -y > /dev/null

	echo -e "${RED}Install Snap${NC}"
	sudo apt-get install snap -y > /dev/null

	echo -e "${RED}Install curl${NC}"
	sudo apt install curl -y > /dev/null

	echo -e "${RED}Install OBS${NC}"
	sudo snap install obs -y > /dev/null

	echo -e "${RED}Replace Nautilus with Nemo${NC}"
	sudo apt install nemo -y > /dev/null
	xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
	gsettings set org.gnome.desktop.background show-desktop-icons false
	sudo apt-get remove nautilus -y > /dev/null

	echo -e "${RED}Add Nemo addons${NC}"
	sudo apt install mediainfo > /dev/null
	wget https://github.com/linux-man/nemo-mediainfo-tab/releases/download/v1.0.3/nemo-mediainfo-tab_1.0.3_all.deb > /dev/null
	sudo dpkg -i nemo-mediainfo-tab_1.0.3_all.deb > /dev/null
	rm nemo-mediainfo-tab_1.0.3_all.deb > /dev/null

	echo -e "${RED}Add new theme${NC}"
	sudo add-apt-repository -y ppa:papirus/papirus > /dev/null
	sudo apt install papirus-icon-theme -y > /dev/null

	echo -e "${RED}Install VLC${NC}"
	sudo apt-get install vlc -y > /dev/null

	echo -e "${RED}Install WINE${NC}"
	sudo apt install -y wine -y > /dev/null

	echo -e "${RED}Install Blender${NC}"
	sudo apt install blender -y > /dev/null
 
	echo -e "${RED}Install Git${NC}"
	sudo apt install git -y > /dev/null

	echo -e "${RED}Install Make${NC}"
	sudo apt install make -y > /dev/null

	echo -e "${RED}gcc${NC}"
	sudo apt install gcc -y > /dev/null

	echo -e "${RED}Downloading Spotify${NC}"
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
	sudo apt-get update > /dev/null
	sudo apt-get install spotify-client -y > /dev/null

	echo -e "${RED}Cracking Spotify${NC}"
	git clone https://github.com/abba23/spotify-adblock-linux.git > /dev/null
	cd spotify-adblock-linux
	wget -O cef.tar.bz2 https://cef-builds.spotifycdn.com/cef_binary_88.1.6%2Bg4fe33a1%2Bchromium-88.0.4324.96_linux64_minimal.tar.bz2
	tar -xf cef.tar.bz2 --wildcards '*/include' --strip-components=1
	make > /dev/null
	sudo make install > /dev/null
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

	echo -e "${RED}Discord${NC}"
	sudo snap install discord

	echo -e "${RED}DroidCam${NC}"
	sudo apt install v4l2loopback-utils v4l2loopback-dkms cmake nasm yasm pkg-config libgtk2.0-dev > /dev/null
	sudo modprobe v4l2loopback > /dev/null
	cd /tmp/
	wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.2.zip
	unzip droidcam_latest.zip -d droidcam
	cd droidcam 
	sudo ./install-client > /dev/null
	cd

	echo -e "${RED}Install Gnome Tweak${NC}"
	sudo apt-get install gnome-tweak-tool -y > /dev/null

	echo -e "${RED}Install torrent${NC}"
	sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
	sudo apt-get update 
	sudo apt-get install qbittorrent -y > /dev/null

	echo -e "${RED}Install ulauncher${NC}"
	wget https://github.com/Ulauncher/Ulauncher/releases/download/5.10.0/ulauncher_5.10.0_all.deb
	sudo dpkg -i ulauncher_5.10.0_all.deb > /dev/null
	echo -e "${RED}Fix broken${NC}"
	sudo apt --fix-broken install -y 

	echo -e "${RED}Dynamic Wallpaper${NC}"
	sudo apt install wallch -y > /dev/null

	echo -e "${RED}Backup${NC}"
	sudo apt install timeshift -y > /dev/null

	echo -e "${RED}Sync with Phone${NC}"
	sudo apt install kdeconnect -y > /dev/null
	
	echo -e "${RED}Recomended software${NC}"
	firefox https://www.blackmagicdesign.com/products/davinciresolve/

else
	sudo apt install curl gnupg2 ca-certificates lsb-release -y
	sudo apt install firewalld
	sudo systemctl start firewalld
	sudo systemctl enable firewalld	
	sudo systemctl stop ufw
	sudo systemctl disable ufw
	sudo apt remove ufw -y
	
	sudo apt install network-manager
	sudo nano /etc/netplan/00-installer-config.yaml || sudo nano /etc/netplan/00*.yaml
	sudo sed -i 's/networkd/NetworkManager/g' /etc/netplan/00*.yaml
	sudo systemctl enable network-manager.service
	sudo systemctl disable systemd-networkd.service
	sudo apt install rkhunter -y
	sudo apt install chkrootkit -y
	sudo apt-get remove certbot -y
	sudo apt install snapd -y
	sudo snap install core 
	sudo snap refresh core 
	sudo apt install nginx
	sudo snap install --classic certbot
	sudo ln -s /snap/bin/certbot /usr/bin/certbot
	sudo apt-get install cockpit
	sudo apt-get install php
	sudo apt-get install lynis
	
	sudo apt install git build-essential
	sudo apt install openjdk-11-jre-headless
	sudo useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
	
	
	echo -e "${RED}sudo certbot --nginx${NC}"
	
	
	
fi
	echo -e "${RED}Done!${NC}"
else
    echo -e "${RED}You cannot procced without accepting EULA!${NC}"
fi

read -p "Press enter to continue"
