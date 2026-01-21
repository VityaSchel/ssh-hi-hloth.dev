#!/bin/bash

set -e

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root (use sudo)"
	exit 1
fi

if id -u hi >/dev/null 2>&1; then
	echo "User 'hi' already exists"
	exit 1
fi

useradd -d /home/hi -s /bin/sh -M -c "ssh hi@hloth.dev" hi

mkdir -p /srv/guest-chroot
chown root:root /srv/guest-chroot
chmod 0755 /srv/guest-chroot

mkdir -p /srv/guest-chroot/home/hi
chown hi:hi /srv/guest-chroot/home/hi
chmod 0755 /srv/guest-chroot/home/hi
