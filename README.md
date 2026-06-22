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
5. Reboot
6. Perform basic configuration via UI
7. Move data from backup
8. Config sensors [readme1](https://github.com/UshakovVasilii/gnome-shell-extension-freon/wiki/FAQ) [readme2](https://wiki.archlinux.org/title/lm_sensors)
9. check dmesg errors with `sudo dmesg --level=emerg,alert,crit,err,warn,notice,info`

## Java installation

The script must be run as root. Run the script without options to see examples of usage.

You must have folders with respecting unarchived JDKs next to the script file.

## Composer installation

Run it as a regular user `./composer_installer.sh`

## NVM & nodejs installation

Run it as a regular user `./nodejs_installer.sh <version>`

## Gnome setup

Setup & config manually
Extensions used:

- <rectangle@acristoffers.me> OR <tilingshell@ferrarodomenico.com>
- just-perfection-desktop@just-perfection
- <clipboard-indicator@tudmotu.com>
- <impatience@gfxmonk.net>
- <freon@UshakovVasilii_Github.yahoo.com>

## Virtual box

If VMs can't run due to

```shell
VirtualBox can't operate in VMX root mode.
Please disable the KVM kernel extension, recompile your kernel and reboot.
(VERR_VMX_IN_VMX_ROOT_MODE).
```

Run `sudo modprobe -r kvm_intel`

## Trick system in thinking you have a JRE without installing one from APT

The trick is to create a tiny “dummy package” that announces: *yes, this system has a compatible Java runtime, you may stand down.* Ubuntu gives you a neat little tool for this called `equivs`.

The interesting part is figuring out what capability your target package needs. `apt show <package>` will tell you the exact virtual package it’s demanding.

The control file for `equivs` can be delightfully tiny. It might look like this:

```
Section: misc
Priority: optional
Standards-Version: 3.9.2
Package: custom-java11-runtime
Version: 1.0
Architecture: all
Provides: java11-runtime
Description: Dummy package declaring a manually installed Java 11+ runtime
 A placeholder allowing apt packages to depend on Java without pulling in OpenJDK.
```

Then run:

```
equivs-build control-file
sudo apt install ./custom-java11-runtime_1.0_all.deb
```

Once installed, APT sees that your system “has” a `java11-runtime` and stops proposing its own. You continue using `update-alternatives` to manage the actual binaries, so your hand-installed JVM stays in full control.

This little trick works because Ubuntu packages don’t care *which* JRE you use, only that something claims the capability. The dummy package becomes that declaration, leaving your own runtime free to shine in its polyglot glory.
