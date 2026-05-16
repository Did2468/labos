FROM --platform=linux/amd64 debian:bookworm

RUN apt update && apt install -y \
    gcc g++ make git wget cpio \
    python3 python3-dev unzip bc \
    rsync file libncurses-dev bzip2 \
    xorriso grub-pc-bin mtools \
    qemu-system-x86

WORKDIR /build

COPY . .

RUN git clone https://gitlab.com/buildroot.org/buildroot.git && \
    cd buildroot && \
    git checkout 2024.02

CMD ["./build.sh"]
