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

PKG_NAME:=heaptrack
PKG_VERSION:=1.1.0
PKG_RELEASE:=1

PKG_SOURCE:=v$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=https://github.com/KDE/heaptrack/archive
PKG_HASH:=bd247ac67d1ecf023ec7e2a2888764bfc03e2f8b24876928ca6aa0cdb3a07309

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk

define Package/heaptrack
  SECTION:=devel
  CATEGORY:=Development
  TITLE:=Heaptrack
  URL:=https://github.com/KDE/heaptrack
  DEPENDS:=+libunwind +boost-system +boost-filesystem +boost-iostreams \
	  +boost-program_options +boost-regex +zlib +zstd
endef

define Package/heaptrack/description
  A heap memory profiler for Linux
  Heaptrack traces all memory allocations and annotates these events with stack traces
endef

CMAKE_OPTIONS:=-DHEAPTRACK_BUILD_GUI=OFF

define Package/heaptrack/install
	$(INSTALL_DIR) $(1)/usr/bin $(1)/usr/lib
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/heaptrack $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/heaptrack_print $(1)/usr/bin/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/heaptrack $(1)/usr/lib/
endef

$(eval $(call BuildPackage,heaptrack))
