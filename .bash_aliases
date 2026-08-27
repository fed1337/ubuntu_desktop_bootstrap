# shellcheck disable=SC2148
# confirmation
alias mv="mv -i"
alias cp="cp -i"
alias ln="ln -i"

# colors
alias ip="ip -c"
alias dmesg="dmesg --color=always -T"
alias fdisk="fdisk --color=always"
alias pcregrep="pcregrep --color=always"
alias watch="watch --color"
alias diff="diff --color=always"
alias dir="dir --color=auto"
alias vdir="vdir --color=always"
alias grep="grep --color=auto"
alias ls="ls --color"

# human readable
alias df="df -h"
alias du="du -h"
alias rsync="rsync -h"
alias systemctl="systemctl --no-pager --full"

# navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# package management
alias update="sudo snap refresh && sudo apt update && sudo apt upgrade"
alias clean="sudo apt autoremove --purge && sudo apt autoclean"

# docker
alias d="docker"
alias dps="docker ps"
alias di="docker image"
alias dc="docker container"
alias dv="docker volume"
alias dex="docker exec -it"

# docker compose
alias dc="docker compose"
alias dcu="docker compose up"
alias dcud="docker compose up --detach"
alias dcub="docker compose up --detach --build"
alias dcd="docker compose down"
alias dcdv="docker compose down --volumes"
alias dcps="docker compose ps"
alias dcl="docker compose logs"
alias dclf="docker compose logs --follow --tail 200"
alias dcb="docker compose build"
alias dcpull="docker compose pull"
alias dcconfig="docker compose config"
alias dcrestart="docker compose restart"

# ansible
alias av="ansible --version"
alias ai="ansible-inventory"
alias aigr="ansible-inventory --graph"
alias ap="ansible-playbook"
alias apcheck="ansible-playbook --check --diff"
alias alint="ansible-lint"

# useful
alias ll="ls -alh"
alias c="clear"
alias h="history"
alias hg="history|grep"
alias extip="curl eth0.me"
alias wget="wget -c"
alias bc="bc -l"
alias mount="mount |column -t"
alias spoofdpi="~/.spoof-dpi/bin/spoof-dpi"
alias ovpn="sudo openvpn --script-security 2 --config"
alias mkdir="mkdir -pv"
alias setproxy="http_proxy='http://127.0.0.1:2080' && export http_proxy"
alias unsetproxy="http_proxy='' && export http_proxy"
alias pscpu="ps auxf | sort -nr -k 3 | head -10"
alias psmem="ps auxf | sort -nr -k 4 | head -10"
alias src="source ~/.bashrc"

# functions
alias urlencode='python3 -c "import sys,urllib.parse; print(urllib.parse.quote(sys.stdin.read().strip()))"'

alias urldecode='python3 -c "import sys,urllib.parse; print(urllib.parse.unquote(sys.stdin.read().strip()))"'
