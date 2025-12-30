#!/bin/bash
set -x

USER=feds

# updating system
apt update
apt upgrade -y

# installing snaps
snap install discord minuet mumble postman qalculate slack telegram-desktop keepassxc smplayer
snap install --classic sublime-text
snap install --classic kubectx
snap install --classic kubectl

# install a bunch of stuff
apt install libfuse2 git apt-transport-https mesa-utils mc htop vlc curl ca-certificates gnome-tweaks samba smbclient p7zip-full ffmpeg gnome-shell-extension-ubuntu-dock ubuntu-drivers-common xz-utils bleachbit meld openvpn jq synaptic ubuntu-restricted-extras redis-tools lm-sensors gnome-shell-extension-manager gnome-shell-extensions smartmontools golang-go ipmitool build-essential gcc make perl cmake gnupg virtualbox-qt variety google-chrome-stable libssl-dev python3-pip python3-argcomplete pipx dconf-editor software-properties-common dupeguru djview4 foliate nmap pdfarranger nmap zenmap libnss3-tools strawberry xchm -y

# java stub package
# equivs-build fake-java-provider
apt install ./fake-java-provider_1.0_all.deb

# symfony-cli
curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | bash
apt update
apt install symfony-cli -y

# jetbrains toolbox
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash

# install peazip GUI archive manager
wget https://github.com/peazip/PeaZip/releases/download/10.8.0/peazip_10.8.0.LINUX.GTK2-1_amd64.deb
apt install ./peazip_10.3.0.LINUX.GTK2-1_amd64.deb

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

# wireguard + gui
apt install wireguard wireguard-tools
wget https://github.com/UnnoTed/wireguird/releases/download/v1.1.0/wireguird_amd64.deb
apt install ./wireguird_amd64.deb

# kse
wget https://github.com/kaikramer/keystore-explorer/releases/download/v5.6.0/kse_5.6.0_all.deb
apt install ./kse_5.6.0_all.deb

# zoom
wget https://zoom.us/client/latest/zoom_amd64.deb
apt install ./zoom_amd64.deb

# rustdesk
wget https://github.com/rustdesk/rustdesk/releases/download/1.4.4/rustdesk-1.4.4-x86_64.deb
apt install ./rustdesk-1.4.4-x86_64.deb

# nekoray
wget https://github.com/MatsuriDayo/nekoray/releases/download/4.0.1/nekoray-4.0.1-2024-12-12-debian-x64.deb
apt install ./nekoray-4.0.1-2024-12-12-debian-x64.deb

# lens
curl -fsSL https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | tee /usr/share/keyrings/lens-archive-keyring.gpg > /dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | tee /etc/apt/sources.list.d/lens.list > /dev/null
apt update
apt install lens

# PHP 8.4 suitable for Symfony
add-apt-repository ppa:ondrej/php
apt update -y
apt install php8.4-curl php8.4-intl php8.4-mbstring php8.4-mysql php8.4-xdebug php8.4-xml

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
# TODO: automate installation of needed versions and choose default
#  may be good idea to symlink to default tool path after some tools are installed
#feds@hp:~$ which node >/dev/null && sudo ln -sf "$(which node)" /usr/local/bin/node
#feds@hp:~$ which npx >/dev/null && sudo ln -sf "$(which npx)" /usr/local/bin/npx

# ansible
pipx install --include-deps ansible
pipx inject --include-apps ansible argcomplete
pipx install ansible-lint
sudo -u $USER -- activate-global-python-argcomplete --user

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
apt autoclean
apt autoremove
rm -f ./*.deb

# TODO: Gnome setup
# don't remember & hide recent files
gsettings set org.gnome.desktop.privacy remember-recent-files false

# copy ssh keys
cp -rp .ssh /home/$USER/.ssh
chmod 0600 /home/$USER/.ssh/id*
ssh-add

# copy configs
cp configs/variety.conf /home/$USER/.config/variety/
cp .gitconfig /home/$USER/
cp .bash_aliases /home/$USER/
chown $USER:$USER /home/$USER/.bash_aliases
chmod 644 /home/$USER/.bash_aliases
cp configs/sensors-custom.conf /etc/sensors.d/

echo -e "Ubuntu Desktop Bootstrap done
IMPORTANT MANUAL STEPS:
1. setup connection to GCP
1.1 gcloud init
1.2 gcloud auth login
2. Use Java installer
3. Use Composer installer and move the binary to /usr/local/bin/composer
4. Install docker using playbook"
