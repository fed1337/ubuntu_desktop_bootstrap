#!/bin/bash
set -x

USER=feds

# updating system
apt update -y
apt upgrade -y

# installing snaps
snap install discord insomnia minuet mumble postman qalculate slack teams-for-linux telegram-desktop nmap keepassxc smplayer drawio
snap install --classic sublime-merge
snap install --classic sublime-text
snap install --classic kubectx
snap install --classic kubectl
snap install --classic kontena-lens

# install a bunch of stuff
apt install libfuse2 git apt-transport-https mesa-utils mc htop vlc curl ca-certificates gnome-tweaks samba smbclient 7zip 7zip-rar 7zip-standalone ffmpeg gnome-shell-extension-ubuntu-dock ubuntu-drivers-common xz-utils bleachbit stacer meld openvpn jq synaptic ubuntu-restricted-extras redis-tools lm-sensors gnome-shell-extension-manager gnome-shell-extensions smartmontools golang-go ipmitool build-essential gcc make perl cmake gnupg virtualbox-qt variety google-chrome-stable libssl-dev python3-pip dconf-editor software-properties-common python3-argcomplete dupeguru -y

# symfony-cli
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
apt update -y
apt install symfony-cli -y

# jetbrains toolbox
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash

# install peazip GUI archive manager
wget https://github.com/peazip/PeaZip/releases/download/10.0.0/peazip_10.0.0.LINUX.GTK2-1_amd64.deb
apt install ./peazip_10.0.0.LINUX.GTK2-1_amd64.deb

# jetbrains mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip
cp -rp JetBrainsMono-2.304/ /usr/share/fonts/JetBrainsMono
fc-cache -f -v
rm -f JetBrainsMono-2.304.zip
rm -r JetBrainsMono-2.304/

# spoof-dpi
curl -fsSL https://raw.githubusercontent.com/xvzc/SpoofDPI/main/install.sh | bash -s linux

# gcloud
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt update
apt install google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin

# ansible
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible ansible-lint

# wireguard + gui
apt install wireguard wireguard-tools
wget https://github.com/UnnoTed/wireguird/releases/download/v1.1.0/wireguird_amd64.deb
apt install ./wireguird_amd64.deb

# kse
wget https://github.com/kaikramer/keystore-explorer/releases/download/v5.5.3/kse_5.5.3_all.deb
apt install ./kse_5.5.3_all.deb

# typora
wget -qO - https://typora.io/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
add-apt-repository 'deb https://typora.io/linux ./'
apt update
apt install install typora

# zoom
wget https://zoom.us/client/6.1.11.1545/zoom_amd64.deb
apt install ./zoom_amd64.deb

# pritunl
#touch /etc/apt/sources.list.d/pritunl.list
#echo "deb https://repo.pritunl.com/stable/apt noble main\n" > /etc/apt/sources.list.d/pritunl.list
#gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 7568D9BB55FF9E5287D586017AE645C0CF8E292A
#gpg --armor --export 7568D9BB55FF9E5287D586017AE645C0CF8E292A | sudo tee /etc/apt/trusted.gpg.d/pritunl.asc
#apt update
#apt install pritunl-client-electron

# nekoray
wget https://github.com/MatsuriDayo/nekoray/releases/download/3.26/nekoray-3.26-2023-12-09-debian-x64.deb
apt install ./nekoray-3.26-2023-12-09-debian-x64.deb

# nvm
cd ~/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# disable tracker 3
su -u $USER 'systemctl --user mask tracker-extract-3.service tracker-miner-fs-3.service tracker-miner-rss-3.service tracker-writeback-3.service tracker-xdg-portal-3.service tracker-miner-fs-control-3.service'
su -u $USER 'tracker3 reset --filesystem --rss'
su -u $USER 'tracker3 reset -s -r'
'Hidden=true' >>/etc/xdg/autostart/tracker-miner-fs-3.desktop
systemctl daemon-reload
chmod -x /usr/libexec/tracker-*
apt-mark hold tracker
apt-mark hold tracker-extract
apt-mark hold tracker-miner-fs

# try to repair stuff that may be broken
apt --fix-broken install -y
apt update --fix-missing -y

# crap cleaning
apt remove gnome-text-editor
apt autoclean -y
apt autoremove -y
apt remove
apt clean
rm -f *.deb

# don't remember & hide recent files
gsettings set org.gnome.desktop.privacy remember-recent-files false

# & hide starred tab & hide "star" column (doesnt work for now)
# https://askubuntu.com/questions/1194319/can-the-starred-folder-in-the-left-pane-of-files-nautilus-be-removed
# https://discourse.gnome.org/t/nautilus-hide-remove-star-column/18343/11
#mkdir -p /home/$USER/.config/nautilus/ui
#gresource extract /bin/nautilus /org/gnome/nautilus/ui/nautilus-window.ui > home/$USER/.config/nautilus/ui/nautilus-window.ui
#export G_RESOURCE_OVERLAYS="/org/gnome/nautilus/ui=home/$USER/.config/nautilus/ui"
#mkdir -p /home/$USER/.config/systemd/user/dbus.service.d/
#touch /home/$USER/.config/systemd/user/dbus.service.d/environment.conf
#echo -e "[Service]
##Environment="G_RESOURCE_OVERLAYS=/org/gnome/nautilus/ui=/home/$USER/.config/nautilus/ui"" >/home/$USER/.config/systemd/user/dbus.service.d/environment.conf

# copy ssh keys
cp -rp .ssh /home/$USER/.ssh
chmod 0600 /home/$USER/.ssh/id*
ssh-add

# copy configs
cp variety.conf /home/$USER/.config/variety/
cp .gitconfig /home/$USER/
cp .bash_aliases /home/$USER/
chown $USER:$USER /home/$USER/.bash_aliases
chmod 644 /home/$USER/.bash_aliases
cp sensors-custom.conf /etc/sensors.d/

echo -e "Ubuntu Desktop Bootstrap done
IMPORTANT MANUAL STEPS:
1. setup connection to GCP: gcloud init
2. active ansible autocompletion: activate-global-python-argcomplete --user"
