#!/bin/bash

set -e

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root (use sudo)"
	exit 1
fi

find /srv/guest-chroot -mindepth 1 -delete

install -d -m 0755 /srv/guest-chroot/{bin,lib,lib64,usr/bin,usr/lib,usr/lib64}

rsync -av --chown=root:root ./guest-chroot/ /srv/guest-chroot

install -d -m 0755 /etc/ssh/sshd_config.d
install -m 0644 ./sshd_config /etc/ssh/sshd_config.d/guest-user.conf

cp /usr/bin/dash /srv/guest-chroot/usr/bin/dash
cp /usr/lib/{libedit.so.0,libc.so.6,libncursesw.so.6} /srv/guest-chroot/usr/lib/
ln -sf /usr/bin/sh /srv/guest-chroot/bin/sh
ln -sf /bin/dash /srv/guest-chroot/usr/bin/sh
ln -sf /usr/bin/dash /srv/guest-chroot/bin/dash
ln -sf /bin/guest-shell.sh /srv/guest-chroot/bin/guest-shell

cp /usr/bin/chafa /srv/guest-chroot/usr/bin/chafa
cp /usr/lib/{libjpeg.so.8,librsvg-2.so.2,libgdk_pixbuf-2.0.so.0,libgio-2.0.so.0,libcairo.so.2,libgobject-2.0.so.0,libtiff.so.6,libwebpdemux.so.2,libwebp.so.7,libjxl.so.0.11,libjxl_threads.so.0.11,libavif.so.16,libheif.so.1,libfreetype.so.6,libchafa.so.0,libglib-2.0.so.0,libm.so.6,libgcc_s.so.1,libdav1d.so.7,libxml2.so.16,libpangocairo-1.0.so.0,libpango-1.0.so.0,libgmodule-2.0.so.0,libglycin-2.so.0,libz.so.1,libmount.so.1,libpng16.so.16,libfontconfig.so.1,libX11.so.6,libXext.so.6,libXrender.so.1,libxcb.so.1,libxcb-render.so.0,libxcb-shm.so.0,libpixman-1.so.0,libffi.so.8,libdeflate.so.0,libjbig.so.2.1,liblzma.so.5,libzstd.so.1,libsharpyuv.so.0,libjxl_cms.so.0.11,libhwy.so.1,libbrotlidec.so.1,libbrotlienc.so.1,libstdc++.so.6,libyuv.so,librav1e.so.0.8,libSvtAv1Enc.so.3,libaom.so.3,libx265.so.215,libde265.so.0,libx264.so.165,libopenh264.so.8,libbz2.so.1.0,libmvec.so.1,libpcre2-8.so.0,libicuuc.so.78,libpangoft2-1.0.so.0,libharfbuzz.so.0,libfribidi.so.0,libthai.so.0,liblcms2.so.2,libseccomp.so.2,libblkid.so.1,libexpat.so.1,libXau.so.6,libXdmcp.so.6,libbrotlicommon.so.1,libicudata.so.78,libgraphite2.so.3,libdatrie.so.1} /srv/guest-chroot/usr/lib/

cp /usr/bin/dirname /srv/guest-chroot/usr/bin/dirname
cp /usr/lib64/ld-linux-x86-64.so.2 /srv/guest-chroot/lib64/
ln -sf /lib64/ld-linux-x86-64.so.2 /srv/guest-chroot/usr/lib64/ld-linux-x86-64.so.2

cp /usr/bin/sed /usr/bin/tr /usr/bin/grep /usr/bin/sleep /usr/bin/stty /srv/guest-chroot/usr/bin/
cp /usr/lib/libacl.so.1 /srv/guest-chroot/usr/lib/libacl.so.1

chown -R root:root /srv/guest-chroot
chmod 0755 /srv/guest-chroot /srv/guest-chroot/bin /srv/guest-chroot/lib /srv/guest-chroot/lib64 /srv/guest-chroot/usr /srv/guest-chroot/usr/bin /srv/guest-chroot/usr/lib /srv/guest-chroot/usr/lib64
chmod 0755 /srv/guest-chroot/usr/bin/dash /srv/guest-chroot/usr/bin/chafa
chmod 0644 /srv/guest-chroot/usr/lib/*.so*
chmod 0755 /srv/guest-chroot/lib64/ld-linux-x86-64.so.2

chmod 0755 /srv/guest-chroot/bin/guest-shell.sh /srv/guest-chroot/bin/utils.sh
find /srv/guest-chroot/screens -name "*.sh" -exec chmod 0755 {} \;
find /srv/guest-chroot/assets -type f -exec chmod 0644 {} \;

install -d -m 0755 /srv/guest-chroot/dev
mknod -m 666 /srv/guest-chroot/dev/null c 1 3