#!/bin/bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root (use sudo)"
	exit 1
fi

CHROOT=/srv/guest-chroot
BINARIES=(/usr/bin/dash /usr/bin/chafa /usr/bin/dirname /usr/bin/grep /usr/bin/ls /usr/bin/sed /usr/bin/sleep /usr/bin/stty /usr/bin/tr)

smoke_test() {
	local bin
	for bin in "${BINARIES[@]:1}"; do
		chroot --userspec="$uid:$gid" "$stage" "$bin" --version >/dev/null || return
	done
	chroot --userspec="$uid:$gid" "$stage" /usr/bin/chafa --probe off --animate off --size 8x4 /assets/bmo.gif >/dev/null || return
	printf 'help\nabout\nme\nexit\n' | chroot --userspec="$uid:$gid" "$stage" /bin/sh -c /bin/guest-shell >/dev/null
}

for bin in "${BINARIES[@]}"; do
	if [[ ! -x $bin ]]; then
		echo "$bin is missing; install its package first (chafa: pacman -S chafa)"
		exit 1
	fi
done

if ! id -u hi >/dev/null 2>&1; then
	useradd -M -p '' -d /home/hi -s /bin/sh -c "ssh hi@hloth.dev" hi
fi
uid=$(id -u hi)
gid=$(id -g hi)

scratch=$(mktemp -d)
stage=$(mktemp -d "$CHROOT.new.XXXXXX")
trap 'rm -rf -- "$stage" "$scratch"' EXIT

cp -R ./guest-chroot/. "$stage"
install -d -m 755 "$stage/dev" "$stage/usr/bin" "$stage/usr/lib"
ln -s usr/lib "$stage/lib64"
ln -s lib "$stage/usr/lib64"
ln -s /usr/bin/dash "$stage/bin/sh"
ln -s /usr/bin/dash "$stage/bin/dash"
ln -s dash "$stage/usr/bin/sh"
ln -s guest-shell.sh "$stage/bin/guest-shell"
mknod -m 666 "$stage/dev/null" c 1 3

deps=$(ldd "${BINARIES[@]}")
if grep 'not found' <<<"$deps"; then
	echo "These libraries are missing"
	exit 1
fi
for bin in "${BINARIES[@]}"; do
	install -m 755 "$bin" "$stage$bin"
done
while IFS= read -r lib; do
	install -m 755 "$lib" "$stage/usr/lib/${lib##*/}"
done < <(grep -oE '/[^ ]+\.so[^ ]*' <<<"$deps" | sort -u)

chmod 755 "$stage"
find "$stage/assets" -type f -exec chmod 644 {} +
find "$stage/bin" "$stage/screens" -type f -exec chmod 755 {} +

if ! smoke_test 2>"$scratch/errors" || [[ -s $scratch/errors ]]; then
	cat "$scratch/errors"
	echo "The guest shell fails in the new chroot, so the live one stays"
	exit 1
fi

install -m 644 -o root -g root ./sshd_config /etc/ssh/sshd_config.d/guest-user.conf

if [[ -d $CHROOT ]]; then
	mv --exchange -T "$stage" "$CHROOT"
else
	mv -T "$stage" "$CHROOT"
fi
