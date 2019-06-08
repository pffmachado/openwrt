#
# Copyright (C) 2019 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=socfpga
BOARDNAME:=Intel Cyclone V SoCs
SUBTARGETS:=generic
FEATURES:=fpu gpio rtc usb usbgadget boot-part rootfs-part squashfs
MAINTAINER:=Paulo Machado <pffmachado@yahoo.com>

KERNEL_PATCHVER:=4.16.7
LINUX_KERNEL_HASH-4.16.7=d87abef6c5666329194a0005fa8331c0cc03b65383f195442dee8f5558af0139

#KERNEL_PATCHVER:=4.19

define Target/Description
	Build firmware images for Intel SoCs Boards.
endef


include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += uboot-envtools mkf2fs e2fsprogs \
	kmod-usb-storage kmod-fs-msdos

$(eval $(call BuildTarget))
