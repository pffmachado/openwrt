#
# Copyright (C) 2010-2012 OpenWrt.org
#
# This Makefile and the code shipped in src/ is free software, licensed
# under the GNU Lesser General Public License, version 2.1 and later.
# See src/COPYING for more information.
#
# Refer to src/COPYRIGHT for copyright statements on the source files.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mkpimage
PKG_RELEASE:=1

PKG_MAINTAINER:=Paulo Machado <pffmachado@yahoo.com>

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/host-build.mk

define Package/mkpimage
  SECTION:=utils
  CATEGORY:=Utilities
  TITLE:=Altera Mkpimage
  DEPENDS:=@TARGET_socfpga
endef

define Build/Configure
endef

define Build/Compile
endef

define Build/InstallDev
endef

define Package/mkpimage/install
endef

define Host/Prepare
	mkdir -p $(HOST_BUILD_DIR)
endef

define Host/Configure

endef

define Host/Compile
	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) \
		src/mkpimage.c -o $(HOST_BUILD_DIR)/mkpimage
endef

define Host/Install
	$(INSTALL_DIR) $(STAGING_DIR_HOST)/bin
	$(INSTALL_BIN) $(HOST_BUILD_DIR)/mkpimage $(STAGING_DIR_HOST)/bin/
endef


$(eval $(call HostBuild))
$(eval $(call BuildPackage,mkpimage))
