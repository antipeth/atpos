# ❄️AntipethOS❄️ 
==========

![ci-badge](https://img.shields.io/static/v1?label=Built%20with&message=NixOS&color=blue&logo=nixos&link=https://nixos.org&labelColor=111212)

##  How to Require 🧊
- You must be running on NixOS.
- Must have installed using GPT & UEFI.
- Please manually edit your config files.

##  How to Install 👊

Run this command to ensure Git & Vim are installed (Because flake need git!!!):

```
nix-shell -p git vim
```

Clone this repo & enter it:

```
git clone https://github.com/antipeth/antipethos.git
cd antipethos
```

copy the example and create your machine config, please replace YourHostname with your machine host name:

```
cp -r hosts/default hosts/YourHostname
```
configurate your config files in YourHostname dir

change the `host` in `flake.nix` to your `YourHostname`

Generate your `hardware.nix` like so:

```
nixos-generate-config --show-hardware-config > hosts/YourHostname/hardware.nix
```

Run this to enable flakes and install the flake replacing YourHostname:

```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#YourHostname
```

Make you ❄️  🥶!

![notbyai](https://notbyai.fyi/img/written-by-human-not-by-ai-white.svg)
