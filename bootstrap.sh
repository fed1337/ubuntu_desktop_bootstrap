#!/bin/bash
set -x

USER=feds

# updating system
apt update -y
apt upgrade -y


# installing snaps
snap install discord insomnia minuet mumble obs-studio postman qalculate skype slack teams-for-linux telegram-desktop nmap keepassxc smplayer drawio
snap install --classic sublime-merge
snap install --classic sublime-text
snap install --classic kubectx
snap install --classic kubectl
snap install --classic kontena-lens
snap install --classic phpstorm

# wireguird
wget https://github.com/UnnoTed/wireguird/releases/download/v1.1.0/wireguird_amd64.deb
dpkg -i ./wireguird_amd64.deb


# kse
wget https://github.com/kaikramer/keystore-explorer/releases/download/v5.5.3/kse_5.5.3_all.deb
dpkg -i ./kse_5.5.3_all.deb


# install a bunch of stuff
apt update -y
apt upgrade -y
apt install libfuse2 git apt-transport-https mesa-utils mc htop vlc curl ca-certificates gnome-tweaks samba smbclient p7zip p7zip-rar rar unrar ffmpeg gnome-shell-extension-ubuntu-dock ubuntu-drivers-common xz-utils bleachbit stacer meld openvpn jq synaptic ubuntu-restricted-extras redis-tools lm-sensors gnome-shell-extension-manager gnome-shell-extensions smartmontools golang-go ipmitool build-essential gcc make perl cmake gnupg virtualbox-qt variety wireguard-tools google-chrome-stable libssl-dev python3-pip dconf-editor -y


# symfony-cli
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
apt update -y
apt install symfony-cli -y


# jetbrains toolbox
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash


# try to repair stuff that may be broken
apt --fix-broken install -y
apt update --fix-missing -y


# delete crap
apt remove gnome-text-editor


# crap cleaning after APT
apt autoclean -y
apt autoremove -y
apt remove
apt clean


# jetbrains mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip 
cp -rp JetBrainsMono-2.304/ /usr/share/fonts/JetBrainsMono
fc-cache -f -v


# spoof-dpi
curl -fsSL https://raw.githubusercontent.com/xvzc/SpoofDPI/main/install.sh | bash -s linux


# gcloud
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt update
apt install google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin
#gcloud init


# nvm
cd ~/
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash


# delete skype autostart
rm /home/$USER/snap/skype/current/.config/autostart/skypeforlinux.desktop


# don't remember & hide recent files
gsettings set org.gnome.desktop.privacy remember-recent-files false


# hide starred tab
mkdir /home/$USER/.config/nautilus/ui
gresource extract /bin/nautilus /org/gnome/nautilus/ui/nautilus-window.ui > ~/.config/nautilus/ui/nautilus-window.ui
export G_RESOURCE_OVERLAYS="/org/gnome/nautilus/ui=home/$USER/.config/nautilus/ui"
mkdir -p /home/$USER/.config/systemd/user/dbus.service.d/
touch /home/$USER/.config/systemd/user/dbus.service.d/environment.conf
echo -e "[Service]
#Environment="G_RESOURCE_OVERLAYS=/org/gnome/nautilus/ui=/home/$USER/.config/nautilus/ui"" > /home/$USER/.config/systemd/user/dbus.service.d/environment.conf


# copying ssh keys
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


echo 'Ubuntu Desktop Bootstrap done'
