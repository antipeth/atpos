# ❄️AntipethOS❄️ 
==========

![ci-badge](https://img.shields.io/static/v1?label=Built%20with&message=NixOS&color=blue&logo=nixos&link=https://nixos.org&labelColor=111212)

![Antipethos1](https://github.com/antipeth/antipethos/blob/main/config/home/files/demo/desktop.png)
![Antipethos2](https://github.com/antipeth/antipethos/blob/main/config/home/files/demo/apps.png)

##  How to Require 🧊
- You must be running on NixOS.
- Must have installed using GPT & UEFI.
- Please manually edit options.nix file.

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

Edit options.nix

Generate your hardware.nix like so:

```
nixos-generate-config --show-hardware-config > hardware.nix
```

Run this to enable flakes and install the flake replacing hostname with whatever you put in the options.nix file:

```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#hostname
```

Make you ❄️  🥶!

![notbyai](https://notbyai.fyi/img/written-by-human-not-by-ai-white.svg)
