#!/bin/bash

 # Copyright � 2016,  Sultan Qasim Khan <sultanqasim@gmail.com> 		      
 # Copyright � 2016,  Varun Chitre  <varun.chitre15@gmail.com>	
 #
 # Custom build script
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 # Please maintain this if you use this script or any part of it
 #

#!/bin/bash
BUILD_START=$(date +"%s")
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'
export ARCH=arm
<<<<<<< HEAD
export SUBARCH=arm
export CROSS_COMPILE=/home/gtrcraft/data/optimus/prebuilts/arm-eabi-4.9/bin/arm-eabi-
echo -e "$red***********************************************"
echo "          Compiling kernel                          "   
echo -e "**********************************************$blue"
rm -f arch/arm/boot/dts/*.dtb
rm -f arch/arm/boot/dt.img
rm -f flash_zip/boot.img
echo -e " Initializing defconfig"
make lux_defconfig
echo -e " Building kernel"
make -C tools/dtbtool
make -j4 zImage
make -j4 dtbs

/home/gtrcraft/data/optimus/msm8916/tools/dtbtool/dtbtool -o /home/gtrcraft/data/optimus/msm8916/arch/arm/boot/dt.img -s 2048 -p /home/gtrcraft/data/optimus/msm8916/scripts/dtc/ /home/gtrcraft/data/optimus/msm8916/arch/arm/boot/dts/

make -j4 modules
echo -e "$yellow*************************"
echo "          Make flashable zip              "
echo -e "*******************************$yellow"
rm -rf gtrcraft_install
mkdir -p gtrcraft_install
make -j4 modules_install INSTALL_MOD_PATH=gtrcraft_install INSTALL_MOD_STRIP=1
mkdir -p flash_zip/system/lib/modules/pronto
find gtrcraft_install/ -name '*.ko' -type f -exec cp '{}' flash_zip/system/lib/modules/ \;
mv flash_zip/system/lib/modules/wlan.ko flash_zip/system/lib/modules/pronto/pronto_wlan.ko
cp arch/arm/boot/zImage flash_zip/tools/
cp arch/arm/boot/dt.img flash_zip/tools/
rm -f /home/gtrcraft/data/optimus/optimus_kernel_rXX.zip
cd flash_zip
zip -r ../arch/arm/boot/optimus_kernel.zip ./
mv /home/gtrcraft/data/optimus/msm8916/arch/arm/boot/optimus_kernel.zip /home/gtrcraft/data/optimus/optimus_kernel_rXX.zip
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$yellow Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
=======
echo "**** Kernel defconfig is set to $KERNEL_DEFCONFIG ****"
make $KERNEL_DEFCONFIG
make -j$JOBS

# Time for dtb
echo "**** Generating DT.IMG ****"
$DTBTOOL/dtbToolCM -2 -o $KERNEL_DIR/arch/arm/boot/dtb -s 2048 -p $KERNEL_DIR/scripts/dtc/ $KERNEL_DIR/arch/arm/boot/dts/

echo "**** Verify zImage,dtb & wlan ****"
ls $KERNEL_DIR/arch/arm/boot/zImage
ls $KERNEL_DIR/arch/arm/boot/dtb
ls $KERNEL_DIR/drivers/staging/prima/wlan.ko

#Anykernel 2 time!!
echo "**** Verifying Anyernel2 Directory ****"
ls $ANY_KERNEL2_DIR
echo "**** Removing leftovers ****"
rm -f $ANY_KERNEL2_DIR/dtb
rm -f $ANY_KERNEL2_DIR/zImage
rm -f $ANY_KERNEL2_DIR/modules/wlan.ko
rm -f $ANY_KERNEL2_DIR/$FINAL_KERNEL_ZIP

echo "**** Copying zImage ****"
cp $KERNEL_DIR/arch/arm/boot/zImage $ANY_KERNEL2_DIR/
echo "**** Copying dtb ****"
cp $KERNEL_DIR/arch/arm/boot/dtb $ANY_KERNEL2_DIR/
echo "**** Copying modules ****"
cp $KERNEL_DIR/drivers/staging/prima/wlan.ko $ANY_KERNEL2_DIR/modules/

echo "**** Time to zip up! ****"
cd $ANY_KERNEL2_DIR/
zip -r9 $FINAL_KERNEL_ZIP * -x README $FINAL_KERNEL_ZIP

echo "**** Here's your zip ****"
ls $ANY_KERNEL2_DIR/$FINAL_KERNEL_ZIP

echo "**** Good Bye!! ****"
cd $KERNEL_DIR
rm -f arch/arm/boot/dtb
>>>>>>> parent of 8731887... build: few adjustments
