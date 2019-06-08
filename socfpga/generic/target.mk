SUBTARGET:=generic
BOARDNAME:=Generic
CPU_TYPE:=cortex-a9
CPU_SUBTYPE:=neon
FEATURES += ext4 usb ramdisk

define Target/Description
	Build firmware images for Intel SoCs based boards.
endef


