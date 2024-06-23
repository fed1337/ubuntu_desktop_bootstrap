# useful
alias ll="ls -alFh"
alias h="history"
alias hg="history|grep"
alias extip="curl eth0.me"
alias dog="cat"
alias wget="wget -c"
alias c="clear"
alias bc="bc -l"
alias mount="mount |column -t"
alias spoofdpi="~/.spoof-dpi/bin/spoof-dpi"
alias ovpn="sudo openvpn --script-security 2 --config"


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
