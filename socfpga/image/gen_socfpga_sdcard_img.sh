#!/usr/bin/env bash

set -ex
[ $# -eq 8 ] || {
    echo "SYNTAX: $0 <file> <bootfs image> <rootfs image> <bootfs size> <rootfs size>"
    exit 1
}

OUTPUT="$1"
UENVIMG="$2"
UVFATIMG="$3"
UBOOTIMG="$4"
ROOTFSIMG="$5"
VFATSIZE="$6"
UBOOTSIZE="$7"
ROOTFSSIZE="$8"

head=4
sect=63

set $(ptgen -o $OUTPUT -h $head -s $sect -l 1024 -t c -p ${VFATSIZE}M -t a2 -p ${UBOOTSIZE}M -t 83 -p ${ROOTFSSIZE}M)

BOOTOFFSET="$(($1 / 512))"
BOOTSIZE="$(($2 / 512))"
UBOOTOFFSET="$(($3 / 512))"
UBOOTSIZE="$(($4 / 512))"
ROOTFSOFFSET="$(($5 / 512))"
ROOTFSSIZE="$(($6 / 512))"

dd bs=512 if="$UENVIMG" of="$OUTPUT" seek=34 conv=notrunc
dd bs=512 if="$UVFATIMG" of="$OUTPUT" seek="$BOOTOFFSET" conv=notrunc
dd bs=512 if="$UBOOTIMG" of="$OUTPUT" seek="$UBOOTOFFSET" conv=notrunc
dd bs=512 if="$ROOTFSIMG" of="$OUTPUT" seek="$ROOTFSOFFSET" conv=notrunc
