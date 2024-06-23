# Ubuntu 24.04 after installation bootstrap


## After OS installation
1. 
```
wget 
chmod +x ubuntu_desktop_bootstrap
sudo ./ubuntu_desktop_bootstrap/bootstrap.sh
```
2. Add .ssh directory with your keys to ubuntu_desktop_bootstrap
3. Edit USER variable in bootstrap.sh accordingly to the name of your user
4. Move to ubuntu_desktop_bootstrap directory and run script as root `sudo ./bootstrap.sh`


## After script execution
- reboot
- check apps
- perform basic configuration via UI
- move data from backup
- install manually:
  - zoom
  - pritunl
  - tor
  - i2p
  - docker
  - k8s
- check disk issues
- check dmesg errors  
```sudo dmesg --level=emerg,alert,crit,err,warn,notice,info```

