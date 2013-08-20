echo "~ANY KERNEL COMPILER~"
    cd /your/path/to/kernel
    export ARCH=arm export CROSS_COMPILE=$ARCH-eabi- export TOOLCHAIN="/your/path/to/toolchain/bin" export PATH=$TOOLCHAIN:${PATH}
    echo "Cleaning up source"
    make clean && make mrproper
    date +%Y%m%d%H%M > CURRENT_VERSION
    echo "Making config"
    make your_defconfig
    echo "Adding Current Version to Kernel"
    cp CURRENT_VERSION .version
    echo "Building Kernel"
    make -j4
    echo "Kernel ready"
    cp -f arch/arm/boot/zImage /your/path/to/kernel_out_folder/zImage
     
    echo "Copying modules"
    rm -f /your/path/to/kernel_out_folder/boot.img-ramdisk/lib/modules/*
     
    find . -name "*.ko" -exec cp {} /your/path/to/kernel_out_folder/boot.img-ramdisk/lib/modules/ \;
     
    cd /your/path/to/kernel_out_folder/boot.img-ramdisk/lib/modules/
     
    for i in $(find . | grep .ko | grep './')
    do

echo $i
        /your/path/to/toolchain/bin/arm-eabi-strip --strip-unneeded $i
done
echo "Stripped Modules"
    echo "All done,Press Enter to Quit"
    read ANS
