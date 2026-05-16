# LabOS

A minimal Linux OS built for CSE lab environments.

## What's included
- Python 3
- vim
- lua
- Terminal
- Nothing else

## Build
```bash
./build.sh
```

## Flash to USB
```bash
sudo dd if=rootfs.iso9660 of=/dev/sdX bs=1m
```

## Use case
Dual boot option for college lab PCs during exams.
No browser, no internet, no cheating surface.
