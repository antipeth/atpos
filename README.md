# ❄️AntipethOS❄️
==========

![ci-badge](https://img.shields.io/static/v1?label=Built%20with&message=NixOS&color=blue&logo=nixos&link=https://nixos.org&labelColor=111212)

![Antipethos1](https://github.com/antipeth/antipethos/blob/main/pic/demo1.webp)
![Antipethos2](https://github.com/antipeth/antipethos/blob/main/pic/demo2.webp)

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
git clone https://github.com/antipeth/atpos.git
cd antipethos
```

copy the example and create your machine config, please replace YourHostname with your machine host name:

```
cp -r hosts/example hosts/YourHostname
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

## Acknowledgements

Config:
- <https://gitlab.com/Zaney/zaneyos>
- <https://github.com/yonzilch/yonos>
- <https://github.com/ryan4yin/nix-config>
- <https://github.com/xddxdd/nixos-config>
- <https://gitea.c3d2.de/c3d2/nix-config>
- <https://github.com/spector700/Akari>
- <https://github.com/redyf/Neve>

Project:
- <https://github.com/ryan4yin/nixos-and-flakes-book>
- <https://github.com/nix-community/nixvim>

![notbyai](https://notbyai.fyi/img/written-by-human-not-by-ai-white.svg)
