# just is a command runner, Justfile is very similar to Makefile, but simpler.

# use nushell for shell commands
set shell := ["bash", "-c"]

############################################################################
#
#  Common commands(suitable for all machines)
#
############################################################################

# set hostname environment
hostname := `hostname`

anywhere input:
  # Perform nixos-anywhere install
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}}

# Perform nixos-anywhere install (local builder)
anywhere-lb input:
  nix run github:nix-community/nixos-anywhere -- --generate-hardware-config nixos-generate-config ./hosts/{{input}}/hardware.nix --flake .#{{input}} --target-host root@{{input}} --build-on local

# Test nixos-anywhere install in vm
anywhere-vm input:
  nix run github:nix-community/nixos-anywhere -- --flake .#{{input}} --vm-test

# Build
build input:
  sudo nixos-rebuild build --flake .#{{input}} --show-trace -L -v

# Build system image
build-image:
  sudo nix build .#image --impure --show-trace -L -v --extra-experimental-features flakes --extra-experimental-features nix-command

# Build a vm
build-vm input:
  sudo nixos-rebuild build-vm --flake .#{{input}} --show-trace -L -v

# Remove useless nix-channel files
clean:
  sudo rm -rf /nix/var/nix/profiles/per-user/root/channels /root/.nix-defexpr/channels

# Use alejandra and deadnix to format code
format:
  deadnix -e
  alejandra .

# Garbage collect all unused nix store entries
gc:
  sudo nix profile wipe-history --older-than 7d --profile /nix/var/nix/profiles/system
  sudo nix-collect-garbage --delete-old

# Generate hardware.nix
ghc:
  sudo nixos-generate-config --show-hardware-config > ./hosts/{{hostname}}/hardware.nix

# Install this flake
install:
  NIX_CONFIG="experimental-features = nix-command flakes"
  nixos-rebuild switch --flake .#{{hostname}} --show-trace -L -v

# List system packages
list:
  nix-store -qR /run/current-system | cat

# List all generations of the system profile
profile:
  sudo nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
repl:
  nix repl -f flake:nixpkgs

# Let system totally upgrade
switch input:
  sudo nixos-rebuild switch --flake .#{{input}} --show-trace -L -v

# Update all the flake inputs
update:
  nix flake update --extra-experimental-features flakes --extra-experimental-features nix-command --show-trace

# Update specific input
upgrade:
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace -L -v

upgrade-debug:
  sudo unbuffer nixos-rebuild switch --flake .#{{hostname}} --sudo --log-format internal-json --show-trace -L -v |& nom --json
