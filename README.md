# Ubuntu 24.04 after installation bootstrap

## After OS installation

1. Download, extract, make script executable `chmod +x ubuntu_desktop_bootstrap-0.2/bootstrap.sh`
2. Add .ssh directory with your keys to the ubuntu_desktop_bootstrap directory
3. Edit the USER variable in bootstrap.sh accordingly to the name of your user
4. Run the script as root `sudo ./bootstrap.sh`

## After script execution

1. Setup connection to GCP (`gcloud init` & `gcloud auth login`)
2. Use Java installer
3. Use Composer installer
4. Use Nodejs installer
5. Use Gnome setup script
6. Reboot
7. Perform basic configuration via UI
8. Move data from backup
9. Perform sensors
   configuration [readme1](https://github.com/UshakovVasilii/gnome-shell-extension-freon/wiki/FAQ) [readme2](https://wiki.archlinux.org/title/lm_sensors)
11. check dmesg errors with `sudo dmesg --level=emerg,alert,crit,err,warn,notice,info`

## Java installation

The script must be run as root. Run the script without options to see examples of usage.

## Composer installation

Run it as user `./composer_installer.sh`

## NVM & nodejs installation

Run it as user `./nodejs_installer.sh`

## Gnome setup
Setup & config manually
Extensions used:
- rectangle@acristoffers.me OR tilingshell@ferrarodomenico.com
- just-perfection-desktop@just-perfection
- clipboard-indicator@tudmotu.com
- impatience@gfxmonk.net
- freon@UshakovVasilii_Github.yahoo.com

## Virtual box
If VMs can't run due to
```
VirtualBox can't operate in VMX root mode.
Please disable the KVM kernel extension, recompile your kernel and reboot.
(VERR_VMX_IN_VMX_ROOT_MODE).
```

Run `sudo modprobe -r kvm_intel`
