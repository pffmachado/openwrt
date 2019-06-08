#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

UBOOT_SOCFPGA_CRC_HEADER_VERSION=0
UBOOT_ENVIMAGE_SIZE=8192

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_TARGET_KERNEL_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

#------------------------------------------------------------------------------
#-- Default Device Configuration
#------------------------------------------------------------------------------

define Device/Default
	PROFILES := Default $$(DEVICE_DTS)
	KERNEL_DEPENDS = $$(wildcard $(DTS_DIR)/$$(DEVICE_DTS).dts)
	KERNEL = kernel-bin
	IMAGES := sdcard.img.gz
	IMAGE/sdcard.img.gz := uboot-env | boot-vfat | uboot-img | sdcard-img
endef

#------------------------------------------------------------------------------
#-- Specific Device Configuration
#------------------------------------------------------------------------------

define Device/terasIC_de1-soc
	DEVICE_TITLE := DE1-SoC Development Board
	DEVICE_DTS := socfpga_cyclone5_socrates
endef
TARGET_DEVICES += terasIC_de1-soc

#------------------------------------------------------------------------------
#-- Image Build Targets
#------------------------------------------------------------------------------

define Build/uboot-env
	@echo "Build/uboot-env ----------------------------------------------------"
	mkenvimage \
		-s $(UBOOT_ENVIMAGE_SIZE) \
		-o $(KERNEL_BUILD_DIR)/uboot-env.bin \
		$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-uEnv.txt
endef

#mkfs.fat $(KERNEL_BUILD_DIR)/boot.vfat -C $(FAT32_BLOCKS)
define Build/boot-vfat
	@echo "Build/boot-vfat ----------------------------------------------------"
	rm -f  $(KERNEL_BUILD_DIR)/boot.vfat
	dd bs=512 count=16384 if=/dev/zero of=$(KERNEL_BUILD_DIR)/boot.vfat
	mkfs.vfat $(KERNEL_BUILD_DIR)/boot.vfat
	mcopy -bsp -i $(KERNEL_BUILD_DIR)/boot.vfat $(LINUX_DIR)/arch/$(LINUX_KARCH)/boot/zImage ::zImage
	mcopy -bsp -i $(KERNEL_BUILD_DIR)/boot.vfat $(KERNEL_BUILD_DIR)/image-socfpga_cyclone5_socrates.dtb ::socfpga_cyclone5_socrates.dtb
endef

define Build/uboot-img
	@echo "Build/uboot-img ----------------------------------------------------"
	rm -f $(KERNEL_BUILD_DIR)/uboot.img
	dd bs=512 count=2048 if=/dev/zero of=$(KERNEL_BUILD_DIR)/uboot.img
	mkpimage \
		-v $(UBOOT_SOCFPGA_CRC_HEADER_VERSION) \
		-o $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot-spl.bin.crc \
		$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot-spl.bin
	dd bs=512 seek=0 conv=notrunc \
		if=$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot-spl.bin.crc \
		of=$(KERNEL_BUILD_DIR)/uboot.img
	dd bs=512 seek=512 conv=notrunc \
		if=$(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-u-boot.img \
		of=$(KERNEL_BUILD_DIR)/uboot.img
endef

define Build/sdcard-img
	@echo "Build/sdcard-img ---------------------------------------------------"
	rm -f $(KERNEL_BUILD_DIR)/sdcard.img
	dd bs=512 count=1 if=/dev/zero of=$(KERNEL_BUILD_DIR)/sdcard.img
	./gen_socfpga_sdcard_img.sh \
		$(KERNEL_BUILD_DIR)/sdcard.img \
		$(KERNEL_BUILD_DIR)/uboot-env.bin \
		$(KERNEL_BUILD_DIR)/boot.vfat \
		$(KERNEL_BUILD_DIR)/uboot.img \
		$(KERNEL_BUILD_DIR)/root.ext4 \
		8 \
		1 \
		500
	$(CP) $(KERNEL_BUILD_DIR)/sdcard.img $(BIN_DIR)/sdcard.img
endef


#------------------------------------------------------------------------------
#-- Build Image
#------------------------------------------------------------------------------

$(eval $(call BuildImage))
