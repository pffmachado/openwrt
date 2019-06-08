#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_VERSION:=2018.03

PKG_HASH:=9f10df88bc91b35642e461217f73256bbaeeca9ae2db8db56197ba5e89e1f6d4

include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/u-boot.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define U-Boot/Default
  BUILD_TARGET:=socfpga
  UBOOT_IMAGE:=spl/boot.bin u-boot.img
  UBOOT_CONFIG:=socfpga_$(1)
  UENV:=default
  HIDDEN:=1
endef

define U-Boot/de1_soc
  NAME:=terasIC DE1-SOC
  BUILD_DEVICES:=terasIC_de1-soc
endef

UBOOT_TARGETS := \
	de1_soc

define Build/InstallDev
	$(INSTALL_DIR) $(STAGING_DIR_IMAGE)
	$(CP) $(PKG_BUILD_DIR)/spl/u-boot-spl.bin $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-u-boot-spl.bin
	$(CP) $(PKG_BUILD_DIR)/u-boot.img $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-u-boot.img
	$(CP) ./files/uEnv-$(UENV).txt $(STAGING_DIR_IMAGE)/$(BUILD_DEVICES)-uEnv.txt
endef

define Package/u-boot/install/default
endef

Build/Exports:=$(Host/Exports)

$(eval $(call BuildPackage/U-Boot))
