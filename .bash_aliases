# useful
alias ll="ls -alCFh"
alias ls="ls -lCF"
alias c="clear"
alias h="history"
alias hg="history|grep"
alias extip="curl eth0.me"
alias dog="cat"
alias wget="wget -c"
alias bc="bc -l"
alias mount="mount |column -t"
alias spoofdpi="~/.spoof-dpi/bin/spoof-dpi"
alias ovpn="sudo openvpn --script-security 2 --config"
alias mkdir="mkdir -pv"

# confirmation #
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
alias vdir="vdir --color=always"

# human readable
alias df="df -h"
alias du="du -h"
alias rsync="rsync -h"
alias systemctl="systemctl --no-pager --full"

# functions
urlencode ()
{
  local args="$@"
  jq -nr --arg v "$args" '$v|@uri';
}

urldecode ()
{
  local url_encoded="${1//+/ }"
  printf '%b' "${url_encoded//%/\\x}"
}
