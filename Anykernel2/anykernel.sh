# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# EDIFY properties
kernel.string=GtrCraft@ xda-developers
do.devicecheck=1
do.initd=0
do.modules=1
do.cleanup=1
device.name1=lux

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;


## AnyKernel permissions
# set permissions for included ramdisk files
chmod -R 755 $ramdisk

## AnyKernel install
dump_boot;

# begin ramdisk changes
insert_line init.qcom.rc "init.optimus.rc" after "import init.target.rc" "import init.optimus.rc";

# end ramdisk changes

write_boot;

## end install

