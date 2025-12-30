#!/usr/bin/bash

set -e

# Check if we are root
if [ "$EUID" -ne 0 ]; then
  echo "${0##*/}: Please run as root!" >&2
  exit 1
fi

help() {
  echo -e "Usage: $0 <option> <object> <priority>
\t <option> can be one of: install, uninstall, config
\t <object> is a path to a java folder
\t <priority> - an integer number defining the priority of a java binaries installing, should be set if the <option> is install, defaults to 100"
  exit 1
}

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "One or both of the parameters are empty"
  help
fi

binaries=$(ls "$2/bin")

for i in $binaries; do
  case $1 in
    "install")
      if [ -z "$3" ]; then
        priority=100
      else
        priority="$3"
      fi
      update-alternatives --install /usr/bin/"$i" "$i" "$2/bin/$i" "$priority"
      ;;
    "uninstall")
      update-alternatives --remove "$i" "$2/bin/$i"
      ;;
    "config")
      update-alternatives --config "$i"
      ;;
    *) help ;;
  esac
done
