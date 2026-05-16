#!/bin/bash
# LabOS Build Script

echo "Installing dependencies..."
apt update && apt install -y \
  gcc g++ make git wget cpio \
  python3 python3-dev unzip bc \
  rsync file libncurses-dev bzip2 \
  xorriso grub-pc-bin mtools qemu-system-x86

echo "Cloning Buildroot 2024.02..."
git clone https://gitlab.com/buildroot.org/buildroot.git
cd buildroot
git checkout 2024.02

echo "Applying LabOS config..."
cp ../configs/labos_x86_defconfig configs/
cp ../patches/grub.cfg fs/iso9660/grub.cfg

make labos_x86_defconfig

echo "Fixing GRUB modules..."
python3 -c "
lines = open('.config').readlines()
out = open('.config', 'w')
for line in lines:
    if 'BR2_TARGET_GRUB2_BUILTIN_MODULES_PC' in line:
        out.write('BR2_TARGET_GRUB2_BUILTIN_MODULES_PC=\"boot linux ext2 fat squash4 part_msdos part_gpt normal biosdisk iso9660 configfile\"\n')
    else:
        out.write(line)
out.close()
print('GRUB modules fixed')
"

echo "Building... (this takes 1-2 hours)"
make -j1

echo "Done. ISO at buildroot/output/images/rootfs.iso9660"
