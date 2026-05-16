#!/bin/bash
# LabOS Build Script

echo "Cloning Buildroot 2024.02..."
git clone https://gitlab.com/buildroot.org/buildroot.git
cd buildroot
git checkout 2024.02

echo "Applying LabOS config..."
cp ../configs/labos_x86_defconfig configs/
cp ../patches/grub.cfg fs/iso9660/grub.cfg

make labos_x86_defconfig
make -j1

echo "Done. ISO at output/images/rootfs.iso9660"
