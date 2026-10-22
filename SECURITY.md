# Security

- A separate user account with limited privileges
- Chrooted into a restricted directory with no access to the rest of the filesystem
- No binaries except for dash (shell), chafa, grep, sed and a few coreutils, with only the libraries they link
- Strict permissions on all files and directories in the chroot
- ForceCommand to restrict the user to the guest shell
- One session per connection; idle sessions close after 15 minutes and connections without one after a minute
- All guests share one systemd slice capped at one CPU core, 1 GiB of memory without swap and 128 tasks
- AllowTcpForwarding disabled to prevent port forwarding
- X11Forwarding disabled to prevent X11 forwarding
- PermitTunnel disabled to prevent tunneling
- AllowAgentForwarding disabled to prevent SSH agent forwarding
- PermitUserRC disabled to prevent execution of user rc files