#!/bin/bash
# Dorian is Quick installator for Ubuntu
# Author : Sherlock3721
#
# Thank you for using Dorian!

#Declaration color
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
NC='\033[0m'

# Start Program
echo -e ""
echo "${RED}Dorian v0.1 by Sherlock3721${NC}"
echo ""
echo "${RED}!!! Warning if you press key you agree with eula !!! ${NC}"
read -r -p "Do you accept EULA? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
    	echo "${RED}Install Steam${NC}"
	sudo apt-get install steam -y

	echo "${RED}Install Python3${NC}"
	sudo apt-get install python3 -y

	echo "${RED}Install FFmpeg${NC}"
	sudo apt-get install ffmpeg -y

	echo -e "${RED}Install Snap${NC}"
	sudo apt-get install snap -y

	echo -e "${RED}Install curl${NC}"
	sudo apt install curl -y

	echo -e "${RED}Install OBS${NC}"
	sudo snap install obs -y

	echo -e "${RED}Replace Nautilus with Nemo${NC}"
	sudo apt install nemo -y
	xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
	gsettings set org.gnome.desktop.background show-desktop-icons false
	sudo apt-get remove nautilus -y

	echo -e "${RED}Add new theme${NC}"
	sudo add-apt-repository -y ppa:papirus/papirus
	sudo apt install papirus-icon-theme -y

	echo -e "${RED}Install VLC${NC}"
	sudo apt-get install vlc -y

	echo -e "${RED}Install WINE${NC}"
	sudo apt install -y wine -y

	echo -e "${RED}Install Blender${NC}"
	sudo apt install blender -y

	echo -e "${RED}Install Git${NC}"
	sudo apt install git -y

	echo -e "${RED}Install Make${NC}"
	sudo apt install make -y 

	echo -e "${RED}gcc${NC}"
	sudo apt install gcc -y

	echo -e "${RED}Downloading Spotify${NC}"
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install spotify-client -y

	echo -e "${RED}Cracking Spotify${NC}"
	git clone https://github.com/abba23/spotify-adblock-linux.git
	cd spotify-adblock-linux
	wget -O cef.tar.bz2 https://cef-builds.spotifycdn.com/cef_binary_88.1.6%2Bg4fe33a1%2Bchromium-88.0.4324.96_linux64_minimal.tar.bz2
	tar -xf cef.tar.bz2 --wildcards '*/include' --strip-components=1
	make
	sudo make install
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

	#wget https://discord.com/api/download?platform=linux&format=deb
	#sudo dpkg -i dis*.deb

	sudo apt install v4l2loopback-utils v4l2loopback-dkms cmake nasm yasm pkg-config libgtk2.0-dev
	sudo modprobe v4l2loopback

	cd /tmp/
	wget -O droidcam_latest.zip https://files.dev47apps.net/linux/droidcam_1.7.2.zip
	# sha1sum: c5154cd85ee4da3b951777dbae156cdb5bea7176
	unzip droidcam_latest.zip -d droidcam
	cd droidcam && sudo ./install-client
	cd

	echo -e "${RED}Install Gnome Tweak${NC}"
	sudo apt-get install gnome-tweak-tool -y

	echo -e "${RED}Install torrent${NC}"
	sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable -y
	sudo apt-get update && sudo apt-get install qbittorrent -y

	echo -e "${RED}Install ulauncher${NC}"
	wget https://github.com/Ulauncher/Ulauncher/releases/download/5.10.0/ulauncher_5.10.0_all.deb
	sudo dpkg -i ulauncher_5.10.0_all.deb
	echo -e "${RED}Fix broken${NC}"
	sudo apt --fix-broken install -y

	sudo apt install wallch -y

	sudo apt install timeshift -y

	sudo apt install kdeconnect -y

	echo -e "${RED}Done!${NC}"
else
    echo -e "${RED}You cannot procced without accepting EULA!${NC}"
fi

read -p "Press enter to continue"

