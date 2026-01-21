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
ln -sf /usr/bin/dash /srv/guest-chroot/bin/sh
ln -sf /bin/guest-shell.sh /srv/guest-chroot/bin/guest-shell
cp /usr/lib/libedit.so.0 /srv/guest-chroot/usr/lib/libedit.so.0
cp /usr/lib/libc.so.6 /srv/guest-chroot/usr/lib/libc.so.6
cp /usr/lib/libncursesw.so.6 /srv/guest-chroot/usr/lib/libncursesw.so.6
cp /usr/lib64/ld-linux-x86-64.so.2 /srv/guest-chroot/lib64/ld-linux-x86-64.so.2
ln -sf /lib64/ld-linux-x86-64.so.2 /srv/guest-chroot/usr/lib64/ld-linux-x86-64.so.2

chown -R root:root /srv/guest-chroot
chmod 0755 /srv/guest-chroot /srv/guest-chroot/bin /srv/guest-chroot/lib /srv/guest-chroot/lib64 /srv/guest-chroot/usr /srv/guest-chroot/usr/bin /srv/guest-chroot/usr/lib /srv/guest-chroot/usr/lib64
chmod 0755 /srv/guest-chroot/usr/bin/dash
chmod 0644 /srv/guest-chroot/usr/lib/libedit.so.0 /srv/guest-chroot/usr/lib/libc.so.6 /srv/guest-chroot/usr/lib/libncursesw.so.6
chmod 0755 /srv/guest-chroot/lib64/ld-linux-x86-64.so.2
