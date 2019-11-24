#
# Copyright © 2019, Krittin Kalra "androbada525"
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it

# Init Script
KERNEL_DIR=$PWD
ZIMAGE=$KERNEL_DIR/BUILT_kenzo-losN/
BUILD_START=$(date +"%s")

# Color Code Script
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
nocol='\033[0m'         # Default

# Tweakable Options Below
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="androbada525"
export KBUILD_BUILD_HOST="nightingale"
export CROSS_COMPILE="/home/krittinkalra/aarch64-linux-android-8.x/bin/aarch64-linux-android-"

# Compilation Scripts Are Below
compile_kernel ()
{
echo -e "$White***********************************************"
echo "         Compiling JackAss kernel             "
echo -e "***********************************************$nocol"
make clean && make mrproper
make jackass_kenzo-losN_defconfig


make -j4

rm -rf $KERNEL_DIR/BUILT_kenzo-losN
mkdir -p $KERNEL_DIR/BUILT_kenzo-losN

find -name '*.ko' -exec mv -v {} $KERNEL_DIR/BUILT_kenzo-losN/ 

mv $KERNEL_DIR/arch/arm64/boot/Image.*-dtb $KERNEL_DIR/BUILT_kenzo-losN/

if ! [ -a $ZIMAGE ];
then
echo -e "$Red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi
}

# Finalizing Script Below
case $1 in
clean)
make ARCH=arm64 -j4 clean mrproper
rm -rf include/linux/autoconf.h
;;
*)
compile_kernel
;;
esac
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$Yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
