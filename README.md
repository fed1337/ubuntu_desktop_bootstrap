# Ubuntu 24.04 after installation bootstrap

## After OS installation

1. Download, extract, make script executable `chmod +x ubuntu_desktop_bootstrap-0.2/bootstrap.sh`
2. Add .ssh directory with your keys to the ubuntu_desktop_bootstrap directory
3. Edit USER variable in bootstrap.sh accordingly to the name of your user
4. Run the script as root `sudo ./bootstrap.sh`

## After script execution

- Reboot
- Check that apps are installed
- Do what the message in the terminal tells you to do
- Perform basic configuration via UI
- Move data from backup
- Perform sensors
configuration [readme1](https://github.com/UshakovVasilii/gnome-shell-extension-freon/wiki/FAQ) [readme2](https://wiki.archlinux.org/title/lm_sensors)
- check disk issues
- check dmesg errors with `sudo dmesg --level=emerg,alert,crit,err,warn,notice,info`

## Java installation

The script must be run as root. Run the script without options to see examples of usage.

## Composer installation

Run it as user `./composer_installer.sh`

## NVM & nodejs installation

Run it as user `./nodejs_installer.sh`

## Virtual box installation
Run as root `sudo ./virtualbox_installer.sh`
If VMs can't run due to
```
VirtualBox can't operate in VMX root mode.
Please disable the KVM kernel extension, recompile your kernel and reboot.
(VERR_VMX_IN_VMX_ROOT_MODE).
```
Run `sudo modprobe -r kvm_intel`
