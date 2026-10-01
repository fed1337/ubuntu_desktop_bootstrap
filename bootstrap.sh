#!/usr/bin/bash

set -x

USER="feds"
ARCH="$(dpkg --print-architecture)"
CODENAME="$(lsb_release -sc)"
PLATFORM="$(uname -m)"

# system update
apt update
apt upgrade -y
snap refresh

# install snaps
snap install discord minuet mumble postman qalculate slack telegram-desktop keepassxc smplayer
snap install --classic kubectx
snap install --classic kubectl
snap install --classic aws-cli

# install a bunch of stuff
apt install libfuse2 git apt-transport-https mesa-utils mc htop vlc curl ca-certificates gnome-tweaks p7zip-full ffmpeg gnome-shell-extension-ubuntu-dock ubuntu-drivers-common xz-utils bleachbit meld openvpn jq ubuntu-restricted-extras redis-tools lm-sensors gnome-shell-extension-manager gnome-shell-extensions ipmitool build-essential gcc make cmake gnupg variety libssl-dev python3-pip python3-argcomplete dconf-editor software-properties-common dupeguru djview4 foliate pdfarranger nmap zenmap libnss3-tools strawberry xchm virtualbox virtualbox-ext-pack shellcheck -y

# java stub package
apt install ./fake-java-provider_1.1_all.deb -y

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_"$ARCH".deb
apt install ./google-chrome-stable_current_"$ARCH".deb -y

# PHP
apt install php8.5 php8.5-{apcu,cli,common,curl,imagick,intl,mbstring,mysql,xdebug,xml} -y

# symfony-cli
wget -qO- https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh | bash
apt update
apt install symfony-cli -y
sudo -u "$USER" bash -c 'symfony completion bash | sudo tee /etc/bash_completion.d/symfony'

# jetbrains toolbox
sudo -u "$USER" bash -c 'wget -qO- https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | bash'

# peazip
wget https://github.com/peazip/PeaZip/releases/download/11.3.0/peazip_11.3.0.LINUX.GTK2-1_"$ARCH".deb
apt install ./peazip_11.3.0.LINUX.GTK2-1_"$ARCH".deb -y

# jetbrains mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304 -d /usr/share/fonts/JetBrainsMono
fc-cache -f -v

# docker
install -m 0755 -d /etc/apt/keyrings
wget -qO- https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $CODENAME stable" | tee /etc/apt/sources.list.d/docker.list
apt update
apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras -y
groupadd docker
usermod -aG docker "$USER"

# docker scout
sudo -u "$USER" bash -c "mkdir /home/$USER/.docker"
sudo -u "$USER" bash -c "wget -qO- https://raw.githubusercontent.com/docker/scout-cli/main/install.sh | sh"

# lens
wget -qO- https://downloads.k8slens.dev/keys/gpg | gpg --dearmor -o /etc/apt/keyrings/lens-archive-keyring.gpg
echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/lens-archive-keyring.gpg] https://downloads.k8slens.dev/apt/debian stable main" | tee /etc/apt/sources.list.d/lens.list
apt update
apt install lens -y

# gcloud
wget -qO- https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/cloud.google.gpg
echo "deb [signed-by=/etc/apt/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee /etc/apt/sources.list.d/google-cloud-sdk.list
apt update
apt install google-cloud-cli google-cloud-cli-gke-gcloud-auth-plugin -y

# wireguard + gui
apt install wireguard wireguard-tools
wget https://github.com/UnnoTed/wireguird/releases/download/v1.1.0/wireguird_"$ARCH".deb
apt install ./wireguird_"$ARCH".deb -y

# kse
wget https://github.com/kaikramer/keystore-explorer/releases/download/v5.7.0/kse_5.7.0-1_all.deb
apt install ./kse_5.7.0-1_all.deb -y

# rustdesk
wget https://github.com/rustdesk/rustdesk/releases/download/1.4.9/rustdesk-1.4.9-"$PLATFORM".deb
apt install ./rustdesk-1.4.9-"$PLATFORM".deb -y

# nekoray
wget https://github.com/MatsuriDayo/nekoray/releases/download/4.0.1/nekoray-4.0.1-2024-12-12-debian-x64.deb
apt install ./nekoray-4.0.1-2024-12-12-debian-x64.deb -y

# vs code
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
echo -e "Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /etc/apt/keyrings/microsoft.gpg" > /etc/apt/sources.list.d/vscode.sources
apt update
apt install code -y

# ripgrep
wget https://github.com/BurntSushi/ripgrep/releases/download/15.2.0/ripgrep_15.2.0-1_"$ARCH".deb
apt install ./ripgrep_15.2.0-1_"$ARCH".deb -y


# uv
sudo -u "$USER" bash -c '
curl -LsSf https://astral.sh/uv/install.sh | sh
grep -qxF '\''export PATH="$HOME/.local/bin:$PATH"'\'' "$HOME/.bashrc" ||
    echo '\''export PATH="$HOME/.local/bin:$PATH"'\'' >> "$HOME/.bashrc"
grep -qxF '\''eval "$(uv generate-shell-completion bash)"'\'' "$HOME/.bashrc" ||
    echo '\''eval "$(uv generate-shell-completion bash)"'\'' >> "$HOME/.bashrc"
grep -qxF '\''eval "$(uvx --generate-shell-completion bash)"'\'' "$HOME/.bashrc" ||
    echo '\''eval "$(uvx --generate-shell-completion bash)"'\'' >> "$HOME/.bashrc"
'

# ansible
su - "$USER" -c "
uv tool install ansible-core
uv tool install ansible-lint
"

# starship (requires nerd-fonts)
# shellcheck disable=SC2016
sudo -u "$USER" bash -c '
mkdir -p "$HOME/.local/share/fonts" &&
cd "$HOME/.local/share/fonts" &&
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz &&
tar xf JetBrainsMono.tar.xz &&
rm JetBrainsMono.tar.xz &&
fc-cache -fv &&
grep -qxF '\''eval "$(starship init bash)"'\'' "$HOME/.bashrc" || echo '\''eval "$(starship init bash)"'\'' >> "$HOME/.bashrc"
'
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes
echo -n "bind 'set mark-directories on'
bind 'set mark-symlinked-directories on'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'
bind 'set completion-ignore-case on'
bind 'set colored-stats on'" | tee -a /home/$USER/.bashrc

# shfmt
wget https://github.com/patrickvane/shfmt/releases/download/master/shfmt_linux_amd64
chmod +x shfmt_linux_amd64
mv ./shfmt_linux_amd64 /usr/local/bin/shfmt

# golangci-lint
sudo -u "$USER" bash -c 'curl -sSfL https://golangci-lint.run/install.sh | sh -s -- -b $(go env GOPATH)/bin v2.14.0'

# crap cleaning
apt autoremove --purge -y
apt autoclean
rm -f ./*.deb
rm -f ./*.zip
rm -f ./*.txt

# copy ssh keys
cp -rp .ssh/* /home/$USER/.ssh/
chmod 0600 /home/$USER/.ssh/id*
ssh-add

# copy configs
cp configs/sensors-custom.conf /etc/sensors.d/
sudo -u "$USER" bash -c '
mkdir -m -0755 /home/$USER/.config/variety
cp configs/variety.conf /home/$USER/.config/variety/
cp .gitconfig /home/$USER/
cp .bash_aliases /home/$USER/
chown $USER:$USER /home/$USER/{.gitconfig,.bash_aliases}
chmod 0644 /home/$USER/{.gitconfig,.bash_aliases}'

# don't remember & hide recent files
gsettings set org.gnome.desktop.privacy remember-recent-files false
