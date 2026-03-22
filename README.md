# Homelab NixOS Configuration

## Deployment

```sh
nixos-anywhere --generate-hardware-config nixos-facter ./facter.json --flake .#homelab --target-host root@${DEVICE-IP}
```
