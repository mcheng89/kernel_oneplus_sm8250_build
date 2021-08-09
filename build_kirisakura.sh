#!/bin/bash

export CLANG_PATH=~/Android_Build/Clang_Google/linux-x86/clang-r399163b/bin
export CLANG_BIN_PATH=~/Android_Build/Clang_Google/linux-x86/clang-r399163b/bin
export PATH=${CLANG_PATH}:${PATH}
export LD_LIBRARY_PATH=~/Android_Build/Clang_Google/linux-x86/clang-r399163b/lib64:$LD_LIBRARY_PATH

echo
echo "Clean Build Directory"
echo 

make O=out CC=clang clean && make O=out CC=clang mrproper

echo
echo "Issue Build Commands"
echo

mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=/home/miles/Downloads/DU_Tools/dtc-aosp
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=aarch64-linux-android-
#export CROSS_COMPILE_ARM32=~/Android_Build/GCC_Google_Arm32/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
export PATH=/root/Android_Build/GCC_Google_Arm64/aarch64-linux-android-4.9/bin/:${PATH}
#${CROSS_COMPILE}as -v

echo
echo "Set DEFCONFIG"
echo 
make O=out CC=clang omega_defconfig

make O=out CC=clang menuconfig

echo
echo "Build The Kernel"
echo 

make -j$(nproc --all) O=out CC=clang

