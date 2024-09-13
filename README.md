# Ubuntu 24.04 after installation bootstrap

## After OS installation

1. Download, extract, make script executable

```
wget https://github.com/fed1337/ubuntu_desktop_bootstrap/archive/refs/tags/v0.2.tar.gz
tar -xf ubuntu_desktop_bootstrap-0.2.tar.gz
chmod +x ubuntu_desktop_bootstrap-0.2/bootstrap.sh
```

2. Add .ssh directory with your keys to ubuntu_desktop_bootstrap directory
3. Edit USER variable in bootstrap.sh accordingly to the name of your user
4. Move to ubuntu_desktop_bootstrap directory and run the script as root `sudo ./bootstrap.sh`

## After script execution

- read the message in terminal
- reboot
- check apps
- perform basic configuration via UI
- move data from backup
- perform sensors
  configuration [readme1](https://github.com/UshakovVasilii/gnome-shell-extension-freon/wiki/FAQ) [readme2](https://wiki.archlinux.org/title/lm_sensors)
- install manually:
  - tor
  - i2p
  - docker
  - k8s
  - php
- check disk issues
- check dmesg errors  
  ```sudo dmesg --level=emerg,alert,crit,err,warn,notice,info```
