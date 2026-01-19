# Security

- A separate user account with limited privileges
- Chrooted into a restricted directory with no access to the rest of the filesystem
- No binaries except for dash (shell) and built ins
- Strict permissions on all files and directories in the chroot
- ForceCommand to restrict the user to the guest shell
- AllowTcpForwarding disabled to prevent port forwarding
- X11Forwarding disabled to prevent X11 forwarding
- PermitTunnel disabled to prevent tunneling
- AllowAgentForwarding disabled to prevent SSH agent forwarding
- PermitUserRC disabled to prevent execution of user rc files