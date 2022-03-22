#!/bin/bash


if command -v mkdepthcharge &> /dev/null; then
mkdepthcharge -o linux/"${1}".kpart \
	--compress none \
	--format fit \
	--arch arm \
	--cmdline "$(cat cmdline)" \
	--vmlinuz linux/arch/arm/boot/zImage \
	--dtbs linux/arch/arm/boot/dts/rk3288-veyron-speedy.dtb
else
echo "Install depthcharge-tools to create a kernel image"
exit 1
fi
exit 0

cd linux

mkimage -D "-I dts -O dtb -p 2048" -f arm.kernel.its vmlinux.uimg || true

vbutil_kernel --pack vmlinux.kpart \
	--version 1 \
	--vmlinuz vmlinux.uimg \
	--arch arm \
	--keyblock /usr/share/vboot/devkeys/kernel.keyblock \
	--signprivate /usr/share/vboot/devkeys/kernel_data_key.vbprivk \
	--config ../cmdline \
	--bootloader ../bootloader.bin
