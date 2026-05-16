# LabOS

A minimal, purpose-built Linux OS for CSE lab environments.

## Problem

Modern lab setups run full Ubuntu or Windows installations — bloated 
with browsers, office tools, and unrestricted internet access. During 
exams, institutions rely on manual invigilation or proctoring software 
to prevent malpractice. Both approaches are fragile.

Students disconnect LAN cables and use mobile hotspots. They use AI 
browser extensions, USB drives, or simply open a new tab. The burden 
falls entirely on the invigilator to catch everything, in real time, 
across an entire lab.

## Solution

LabOS is a bootable Linux environment with exactly what a CS lab needs 
and nothing else. No browser. No package manager exposed to students. 
No internet. No surface to cheat through.

The constraint is architectural, not policy-based.

## What's included

- Python 3
- lua
- ruby
- vi editor
- A terminal (BusyBox shell)
- Nothing else

## Design decisions

- Pure TTY — no display server, no GUI, no X11
- Boots in under 10 seconds on hardware from 2005
- ~65MB ISO
- Built on Linux 6.1 + BusyBox userland via Buildroot

## Use case

Deploy as a dualboot option alongside the existing OS on lab machines.
Normal classes → boot normally. Exam day → boot LabOS. No proctoring 
software needed. No browser to lock down. No hotspot workaround exists.

## Build

Requires a Debian-based x86 Docker container.

```bash
git clone https://github.com/Did2468/labos
cd labos
# inside a debian:bookworm x86 docker container
./build.sh
```

Output: `buildroot/output/images/rootfs.iso9660`

Build time: approximately 3-4 hours on first run.

## Flash to USB

```bash
sudo dd if=rootfs.iso9660 of=/dev/sdX bs=1m status=progress
```
## Steps to boot
while booting on real hardare it boots into grub loader use these commands to boot into the os
```bash
set root=(cd)
linux /boot/bzImage root=/dev/vda1 console=ttyS0 nomodeset noapic acpi=off
initrd /boot/initrd
boot
```
this will directly boot into the LabOs login as root(no password is required)
this will take u into a shell and u can work accordingly.
## Tech stack

- Buildroot 2024.02
- Linux kernel 6.1.44
- BusyBox 1.36
- GRUB2 bootloader
- Target: x86_64

## Status

v0.1 — boots, python3 works, ruby works, vi works. Tested in QEMU and UTM.
Java and gcc support planned for future versions.
User based system also in progress

## Author

Built by Likhith Reddy Kaliki.
