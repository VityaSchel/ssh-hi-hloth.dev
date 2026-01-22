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

# Copy dash
cp /usr/bin/dash /srv/guest-chroot/usr/bin/dash
ln -sf /usr/bin/dash /srv/guest-chroot/bin/dash
ln -sf /bin/guest-shell.sh /srv/guest-chroot/bin/guest-shell

# Copy chafa
cp /usr/bin/chafa /srv/guest-chroot/usr/bin/chafa

# Copy dash libraries
cp /usr/lib/libedit.so.0 /srv/guest-chroot/usr/lib/libedit.so.0
cp /usr/lib/libc.so.6 /srv/guest-chroot/usr/lib/libc.so.6
cp /usr/lib/libncursesw.so.6 /srv/guest-chroot/usr/lib/libncursesw.so.6

# Copy chafa libraries
cp /usr/lib/libjpeg.so.8 /srv/guest-chroot/usr/lib/libjpeg.so.8
cp /usr/lib/librsvg-2.so.2 /srv/guest-chroot/usr/lib/librsvg-2.so.2
cp /usr/lib/libgdk_pixbuf-2.0.so.0 /srv/guest-chroot/usr/lib/libgdk_pixbuf-2.0.so.0
cp /usr/lib/libgio-2.0.so.0 /srv/guest-chroot/usr/lib/libgio-2.0.so.0
cp /usr/lib/libcairo.so.2 /srv/guest-chroot/usr/lib/libcairo.so.2
cp /usr/lib/libgobject-2.0.so.0 /srv/guest-chroot/usr/lib/libgobject-2.0.so.0
cp /usr/lib/libtiff.so.6 /srv/guest-chroot/usr/lib/libtiff.so.6
cp /usr/lib/libwebpdemux.so.2 /srv/guest-chroot/usr/lib/libwebpdemux.so.2
cp /usr/lib/libwebp.so.7 /srv/guest-chroot/usr/lib/libwebp.so.7
cp /usr/lib/libjxl.so.0.11 /srv/guest-chroot/usr/lib/libjxl.so.0.11
cp /usr/lib/libjxl_threads.so.0.11 /srv/guest-chroot/usr/lib/libjxl_threads.so.0.11
cp /usr/lib/libavif.so.16 /srv/guest-chroot/usr/lib/libavif.so.16
cp /usr/lib/libheif.so.1 /srv/guest-chroot/usr/lib/libheif.so.1
cp /usr/lib/libfreetype.so.6 /srv/guest-chroot/usr/lib/libfreetype.so.6
cp /usr/lib/libchafa.so.0 /srv/guest-chroot/usr/lib/libchafa.so.0
cp /usr/lib/libglib-2.0.so.0 /srv/guest-chroot/usr/lib/libglib-2.0.so.0
cp /usr/lib/libm.so.6 /srv/guest-chroot/usr/lib/libm.so.6
cp /usr/lib/libgcc_s.so.1 /srv/guest-chroot/usr/lib/libgcc_s.so.1
cp /usr/lib/libdav1d.so.7 /srv/guest-chroot/usr/lib/libdav1d.so.7
cp /usr/lib/libxml2.so.16 /srv/guest-chroot/usr/lib/libxml2.so.16
cp /usr/lib/libpangocairo-1.0.so.0 /srv/guest-chroot/usr/lib/libpangocairo-1.0.so.0
cp /usr/lib/libpango-1.0.so.0 /srv/guest-chroot/usr/lib/libpango-1.0.so.0
cp /usr/lib/libgmodule-2.0.so.0 /srv/guest-chroot/usr/lib/libgmodule-2.0.so.0
cp /usr/lib/libglycin-2.so.0 /srv/guest-chroot/usr/lib/libglycin-2.so.0
cp /usr/lib/libz.so.1 /srv/guest-chroot/usr/lib/libz.so.1
cp /usr/lib/libmount.so.1 /srv/guest-chroot/usr/lib/libmount.so.1
cp /usr/lib/libpng16.so.16 /srv/guest-chroot/usr/lib/libpng16.so.16
cp /usr/lib/libfontconfig.so.1 /srv/guest-chroot/usr/lib/libfontconfig.so.1
cp /usr/lib/libX11.so.6 /srv/guest-chroot/usr/lib/libX11.so.6
cp /usr/lib/libXext.so.6 /srv/guest-chroot/usr/lib/libXext.so.6
cp /usr/lib/libXrender.so.1 /srv/guest-chroot/usr/lib/libXrender.so.1
cp /usr/lib/libxcb.so.1 /srv/guest-chroot/usr/lib/libxcb.so.1
cp /usr/lib/libxcb-render.so.0 /srv/guest-chroot/usr/lib/libxcb-render.so.0
cp /usr/lib/libxcb-shm.so.0 /srv/guest-chroot/usr/lib/libxcb-shm.so.0
cp /usr/lib/libpixman-1.so.0 /srv/guest-chroot/usr/lib/libpixman-1.so.0
cp /usr/lib/libffi.so.8 /srv/guest-chroot/usr/lib/libffi.so.8
cp /usr/lib/libdeflate.so.0 /srv/guest-chroot/usr/lib/libdeflate.so.0
cp /usr/lib/libjbig.so.2.1 /srv/guest-chroot/usr/lib/libjbig.so.2.1
cp /usr/lib/liblzma.so.5 /srv/guest-chroot/usr/lib/liblzma.so.5
cp /usr/lib/libzstd.so.1 /srv/guest-chroot/usr/lib/libzstd.so.1
cp /usr/lib/libsharpyuv.so.0 /srv/guest-chroot/usr/lib/libsharpyuv.so.0
cp /usr/lib/libjxl_cms.so.0.11 /srv/guest-chroot/usr/lib/libjxl_cms.so.0.11
cp /usr/lib/libhwy.so.1 /srv/guest-chroot/usr/lib/libhwy.so.1
cp /usr/lib/libbrotlidec.so.1 /srv/guest-chroot/usr/lib/libbrotlidec.so.1
cp /usr/lib/libbrotlienc.so.1 /srv/guest-chroot/usr/lib/libbrotlienc.so.1
cp /usr/lib/libstdc++.so.6 /srv/guest-chroot/usr/lib/libstdc++.so.6
cp /usr/lib/libyuv.so /srv/guest-chroot/usr/lib/libyuv.so
cp /usr/lib/librav1e.so.0.8 /srv/guest-chroot/usr/lib/librav1e.so.0.8
cp /usr/lib/libSvtAv1Enc.so.3 /srv/guest-chroot/usr/lib/libSvtAv1Enc.so.3
cp /usr/lib/libaom.so.3 /srv/guest-chroot/usr/lib/libaom.so.3
cp /usr/lib/libx265.so.215 /srv/guest-chroot/usr/lib/libx265.so.215
cp /usr/lib/libde265.so.0 /srv/guest-chroot/usr/lib/libde265.so.0
cp /usr/lib/libx264.so.165 /srv/guest-chroot/usr/lib/libx264.so.165
cp /usr/lib/libopenh264.so.8 /srv/guest-chroot/usr/lib/libopenh264.so.8
cp /usr/lib/libbz2.so.1.0 /srv/guest-chroot/usr/lib/libbz2.so.1.0
cp /usr/lib/libmvec.so.1 /srv/guest-chroot/usr/lib/libmvec.so.1
cp /usr/lib/libpcre2-8.so.0 /srv/guest-chroot/usr/lib/libpcre2-8.so.0
cp /usr/lib/libicuuc.so.78 /srv/guest-chroot/usr/lib/libicuuc.so.78
cp /usr/lib/libpangoft2-1.0.so.0 /srv/guest-chroot/usr/lib/libpangoft2-1.0.so.0
cp /usr/lib/libharfbuzz.so.0 /srv/guest-chroot/usr/lib/libharfbuzz.so.0
cp /usr/lib/libfribidi.so.0 /srv/guest-chroot/usr/lib/libfribidi.so.0
cp /usr/lib/libthai.so.0 /srv/guest-chroot/usr/lib/libthai.so.0
cp /usr/lib/liblcms2.so.2 /srv/guest-chroot/usr/lib/liblcms2.so.2
cp /usr/lib/libseccomp.so.2 /srv/guest-chroot/usr/lib/libseccomp.so.2
cp /usr/lib/libblkid.so.1 /srv/guest-chroot/usr/lib/libblkid.so.1
cp /usr/lib/libexpat.so.1 /srv/guest-chroot/usr/lib/libexpat.so.1
cp /usr/lib/libXau.so.6 /srv/guest-chroot/usr/lib/libXau.so.6
cp /usr/lib/libXdmcp.so.6 /srv/guest-chroot/usr/lib/libXdmcp.so.6
cp /usr/lib/libbrotlicommon.so.1 /srv/guest-chroot/usr/lib/libbrotlicommon.so.1
cp /usr/lib/libicudata.so.78 /srv/guest-chroot/usr/lib/libicudata.so.78
cp /usr/lib/libgraphite2.so.3 /srv/guest-chroot/usr/lib/libgraphite2.so.3
cp /usr/lib/libdatrie.so.1 /srv/guest-chroot/usr/lib/libdatrie.so.1

# Copy ld-linux
cp /usr/lib64/ld-linux-x86-64.so.2 /srv/guest-chroot/lib64/ld-linux-x86-64.so.2
ln -sf /lib64/ld-linux-x86-64.so.2 /srv/guest-chroot/usr/lib64/ld-linux-x86-64.so.2

chown -R root:root /srv/guest-chroot
chmod 0755 /srv/guest-chroot /srv/guest-chroot/bin /srv/guest-chroot/lib /srv/guest-chroot/lib64 /srv/guest-chroot/usr /srv/guest-chroot/usr/bin /srv/guest-chroot/usr/lib /srv/guest-chroot/usr/lib64
chmod 0755 /srv/guest-chroot/usr/bin/dash /srv/guest-chroot/usr/bin/chafa
chmod 0644 /srv/guest-chroot/usr/lib/*.so*
chmod 0755 /srv/guest-chroot/lib64/ld-linux-x86-64.so.2

chmod 0755 /srv/guest-chroot/bin/guest-shell.sh /srv/guest-chroot/bin/utils.sh
find /srv/guest-chroot/screens -name "*.sh" -exec chmod 0755 {} \;
find /srv/guest-chroot/assets -type f -exec chmod 0644 {} \;
