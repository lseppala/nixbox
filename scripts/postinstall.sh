#!/bin/sh

# Make sure we are totally up to date

nix-channel --add http://nixos.org/channels/nixos-14.04 nixos
nixos-rebuild switch --upgrade

# Cleanup any previous generations and delete old packages that can be
# pruned.

for x in `seq 0 2` ; do
    nix-env --delete-generations old
    nix-collect-garbage -d
done

# Zero out the disk (for better compression)

dd if=/dev/zero of=/EMPTY bs=1M
rm -rf /EMPTY
