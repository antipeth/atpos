# just is a command runner, Justfile is very similar to Makefile, but simpler.

# use nushell for shell commands
set shell := ["nu", "-c"]

############################################################################
#
#  Common commands(suitable for all machines)
#
############################################################################

# set hostname environment
hostname := `hostname`

# build system image
build-image:
  sudo nix build .#image --impure --show-trace -L -v --extra-experimental-features flakes --extra-experimental-features nix-command

# build
build input:
  sudo nixos-rebuild build --flake .#{{input}} --show-trace -L -v

# build a vm
build-vm input:
  sudo nixos-rebuild build-vm --flake .#{{input}} --show-trace -L -v

# remove all generations older than 7 days
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d
# Garbage collect all unused nix store entries
gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old

# generate hardware.nix
hardware:
  sudo nixos-generate-config --show-hardware-config > ./hosts/{{hostname}}/hardware.nix

# install this flake
install:
  NIX_CONFIG="experimental-features = nix-command flakes"
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace -L -v

# list system packages
list:
  sudo nix-store -qR /run/current-system | cat

# List all generations of the system profile
profile:
  nix profile history --profile /nix/var/nix/profiles/system

# Open a nix shell with the flake
repl:
  nix repl -f flake:nixpkgs

# let system totally upgrade
switch input:
  sudo nixos-rebuild switch --flake .#{{input}} --show-trace -L -v

# update all the flake inputs
update:
  nix flake update

# Update specific input
# Usage: just upp nixpkgs
upp input:
  nix flake lock --update-input {{input}}

upgrade:
  # let system totally upgrade
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace -L -v

upgrade-debug:
  # let system totally upgrade (deBug Mode)
  sudo nixos-rebuild switch --flake .#{{hostname}} --log-format internal-json --show-trace -L -v |& nom --json

format:
  # Use alejandra and deadnix to format code
  deadnix -e
  alejandra .
