#!/bin/sh

# Stop on error
set -e

# copy the kernel image to rootfs
cp -a "${BINARIES_DIR}/Image" "${TARGET_DIR}/"

# create VERSION file
echo "VERSION=${PRODUCT_VERSION}" >"${TARGET_DIR}/VERSION"
echo "PRODUCT=${PRODUCT}" >>"${TARGET_DIR}/VERSION"
echo "PLATFORM=odroid-c2" >>"${TARGET_DIR}/VERSION"

# fix some permissions
[ -e "${TARGET_DIR}/etc/monitrc" ] && chmod 600 "${TARGET_DIR}/etc/monitrc"

# rename some stuff buildroot introduced but we need differently
[ -e "${TARGET_DIR}/etc/init.d/S10udev" ] && mv -f "${TARGET_DIR}/etc/init.d/S10udev" "${TARGET_DIR}/etc/init.d/S00udev"

# remove unnecessary stuff from TARGET_DIR
rm -f "${TARGET_DIR}/etc/init.d/S50crond"

# link VERSION in /boot on rootfs
mkdir -p "${TARGET_DIR}/boot"
ln -sf ../VERSION "${TARGET_DIR}/boot/VERSION"
