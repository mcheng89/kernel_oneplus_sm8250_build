FROM ubuntu:latest

RUN apt update && apt upgrade -fy

RUN apt install -y git build-essential curl python bison flex bc libssl-dev

RUN mkdir -p ~/Android_Build/Clang_Google/
RUN cd ~/Android_Build/Clang_Google/ && \
    git clone https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86

RUN mkdir -p ~/Android_Build/GCC_Google_Arm64/
RUN cd ~/Android_Build/GCC_Google_Arm64/ && \
    git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9

RUN mkdir -p ~/Android_Build/Misc
RUN cd ~/Android_Build/Misc && \
    git clone https://android.googlesource.com/platform/prebuilts/misc

# Download the kernel
RUN mkdir -p /kernel
RUN cd /kernel && \
    git clone https://github.com/kristofpetho/kernel_oneplus_sm8250.git
RUN cd /kernel/kernel_oneplus_sm8250

# todo... remove me...
RUN apt update && apt upgrade -fy

# For menuconfig
RUN apt install -y libncurses-dev

# Extra deps?
RUN apt install -y cpio

COPY main.sh /kernel/kernel_oneplus_sm8250
RUN chmod 700 /kernel/kernel_oneplus_sm8250/main.sh

COPY build_kirisakura.sh /kernel/kernel_oneplus_sm8250
RUN chmod 700 /kernel/kernel_oneplus_sm8250/build_kirisakura.sh

# For dtb split
RUN apt install -y python3
COPY extract-dtb.py /kernel/

WORKDIR /kernel/kernel_oneplus_sm8250

CMD ./main.sh

