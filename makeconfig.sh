#directories
KERNEL_DIR=$PWD

export CROSS_COMPILE="/home/krittin/aarch64-linux-android-8.x/bin/aarch64-linux-android-"
export ARCH=arm64
export SUBARCH=arm64
export USE_CCACHE=1
make clean > /dev/null
make jackass_kenzo-losN_defconfig
export KBUILD_BUILD_HOST="nightingdale"
export KBUILD_BUILD_USER="androbada525"
make menuconfig
cp jackass_defconfig arch/arm64/configs/jackass_kenzo-losN_defconfig
echo -e "$cyan Config Copied $nc"