apt-get install cpio

mkdir -p /home/miles/Downloads/DU_Tools/
cp ~/Android_Build/Misc/misc/linux-x86/dtc/dtc /home/miles/Downloads/DU_Tools/dtc-aosp

cd ~/Android_Build/Clang_Google/linux-x86
git fetch --all
git pull origin master

cd /kernel/kernel_oneplus_sm8250

git config --global user.email "test@example.com"
git fetch --all
git checkout omega-11.0
git reset --hard origin/omega-11.0

# ln -sf ../../../drivers/pinctrl/pinctrl-utils.h ./techpack/audio/soc/pinctrl-utils.h
# ln -sf ../../../drivers/pinctrl/core.h ./techpack/audio/soc/core.h
# ln -sf ../../../../drivers/base/regmap/internal.h ./techpack/audio/include/soc/internal.h

./build_kirisakura.sh

cp -r out/arch/arm64/boot /kernel/output/

# cat out/arch/arm64/boot/.Image.gz-dtb.cmd

# echo Image.gz and dtb files are needed
# echo creating dtb file from .Image.gz-dtb

find out/arch/arm64/boot/dts/vendor/qcom -name '*.dtb' -exec echo {} \;
find out/arch/arm64/boot/dts/vendor/qcom -name '*.dtb' -exec cat {} + > /kernel/output/boot/dtb_v2

# cd /kernel/output/boot
# python3 /kernel/extract-dtb.py -o /kernel/output/boot Image.gz-dtb


