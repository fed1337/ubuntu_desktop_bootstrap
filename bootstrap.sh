#!/usr/bin/bash

set -x

USER="feds"
ARCH="$(dpkg --print-architecture)"
CODENAME="$(lsb_release -sc)"

# updating system
apt update
apt upgrade -y
snap refresh

# installing snaps
snap install discord minuet mumble postman qalculate slack telegram-desktop keepassxc smplayer
snap install --classic kubectx
snap install --classic kubectl

# install a bunch of stuff
apt install libfuse2 git apt-transport-https mesa-utils mc htop vlc curl ca-certificates gnome-tweaks smbclient p7zip-full ffmpeg gnome-shell-extension-ubuntu-dock ubuntu-drivers-common xz-utils bleachbit meld openvpn jq ubuntu-restricted-extras redis-tools lm-sensors gnome-shell-extension-manager gnome-shell-extensions golang-go ipmitool build-essential gcc make perl cmake gnupg variety libssl-dev python3-pip python3-argcomplete pipx dconf-editor software-properties-common dupeguru djview4 foliate nmap pdfarranger nmap zenmap libnss3-tools strawberry xchm virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso virtualbox-guest-utils -y

# java stub package
# equivs-build fake-java-provider
apt install ./fake-java-provider_1.0_all.deb -y

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt install ./google-chrome-stable_current_amd64.deb -y

# PHP 8.4 suitable for Symfony
add-apt-repository ppa:ondrej/php
apt update -y
apt install php8.4-curl php8.4-intl php8.4-mbstring php8.4-mysql php8.4-xdebug php8.4-xml -y

# symfony-cli
wget -qO- https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh | bash
apt update
apt install symfony-cli -y
sudo -u "$USER" bash -c 'symfony completion bash | sudo tee /etc/bash_completion.d/symfony'

# jetbrains toolbox
sudo -u "$USER" bash -c 'wget -qO- https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash'

# install peazip GUI archive manager
wget https://github.com/peazip/PeaZip/releases/download/10.8.0/peazip_10.8.0.LINUX.GTK2-1_amd64.deb
apt install ./peazip_10.8.0.LINUX.GTK2-1_amd64.deb -y

# jetbrains mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip
cp -rp JetBrainsMono-2.304/ /usr/share/fonts/JetBrainsMono
fc-cache -f -v
rm -f JetBrainsMono-2.304.zip
rm -r JetBrainsMono-2.304/

# spoof-dpi
wget -qO- https://raw.githubusercontent.com/xvzc/SpoofDPI/main/install.sh | bash -s linux
mkdir -p /home/$USER/.spoof-dpi/bin
ln -s /usr/local/bin/spoofdpi /home/$USER/.spoof-dpi/bin/spoof-dpi

# gcloud
wget -qO- https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
apt update
apt install google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin -y

# wireguard + gui
apt install wireguard wireguard-tools
wget https://github.com/UnnoTed/wireguird/releases/download/v1.1.0/wireguird_amd64.deb
apt install ./wireguird_amd64.deb -y

# kse
wget https://github.com/kaikramer/keystore-explorer/releases/download/v5.6.0/kse_5.6.0_all.deb
apt install ./kse_5.6.0_all.deb -y

# rustdesk
wget https://github.com/rustdesk/rustdesk/releases/download/1.4.4/rustdesk-1.4.4-x86_64.deb
apt install ./rustdesk-1.4.4-x86_64.deb -y

# nekoray
wget https://github.com/MatsuriDayo/nekoray/releases/download/4.0.1/nekoray-4.0.1-2024-12-12-debian-x64.deb
apt install ./nekoray-4.0.1-2024-12-12-debian-x64.deb -y

# lens
wget -qO- https://downloads.k8slens.dev/keys/gpg | gpg --dearmor | tee /usr/share/keyrings/lens-archive-keyring.gpg >/dev/null
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | tee /etc/apt/sources.list.d/lens.list >/dev/null
apt update
apt install lens -y

# ansible
sudo -u "$USER" bash -c 'pipx install --include-deps ansible'
sudo -u "$USER" bash -c 'pipx inject --include-apps ansible argcomplete'
sudo -u "$USER" bash -c 'pipx install ansible-lint'
sudo -u "$USER" -- activate-global-python-argcomplete --user
sudo -u "$USER" bash -c 'pipx ensurepath'

# disable tracker 3
# run tracker3 reset -s -r -- to save some space if the system has been running for some time
sudo -u "$USER" bash -c 'systemctl --user mask tracker-extract-3.service tracker-miner-fs-3.service tracker-miner-rss-3.service tracker-writeback-3.service tracker-xdg-portal-3.service tracker-miner-fs-control-3.service'
sudo -u "$USER" bash -c 'systemctl daemon-reload'
chmod -x /usr/libexec/tracker-*
apt-mark hold tracker
apt-mark hold tracker-extract
apt-mark hold tracker-miner-fs

# crap cleaning
apt autoclean
apt autoremove -y
rm -f ./*.deb

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
"
