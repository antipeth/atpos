#!/usr/bin/env bash

echo "Now Going To Build AntipethOS, 🤞"
NIX_CONFIG="experimental-features = nix-command flakes"
sudo nixos-rebuild switch --flake .#${hostName}
