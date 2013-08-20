    echo "~M7 KERNEL COMPILER~"
    cd /home/tal/Desktop/m7
    export ARCH=arm export CROSS_COMPILE=$ARCH-eabi- export TOOLCHAIN="/home/tal/linaro-4.7/bin" export PATH=$TOOLCHAIN:${PATH}
    echo "Cleaning up source"
    make clean && make mrproper
    date +%Y%m%d%H%M > CURRENT_VERSION
    echo "Making config"
    make cyanogenmod_m7_defconfig
    echo "Adding Current Version to Kernel"
    cp CURRENT_VERSION .version
    echo "Building Kernel"
    make -j7
    echo "Kernel ready"
    cp -f arch/arm/boot/zImage /home/tal/Desktop/kernel_out/zImage
     
    echo "Copying modules"
    rm -f /home/tal/Desktop/kernel_out/boot.img-ramdisk/lib/modules/*
     
    find . -name "*.ko" -exec cp {} /home/tal/android/kernel/purple-flare/m7/m7wls/boot.img-ramdisk/lib/modules/ \;
     
    cd /home/tal/Desktop/kernel_out/boot.img-ramdisk/lib/modules/
     
    for i in $(find . | grep .ko | grep './')
    do
     
    echo "Stripped Modules"
    echo "All done,Press Enter to Quit"
    read ANS


