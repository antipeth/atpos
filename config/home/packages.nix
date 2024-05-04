{ pkgs, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}" _64gram anytype atuin betterbird bitwarden brave copyq discord 
    firefox-devedition font-awesome ghostwriter gitui gopass imv just keepassxc
    libreoffice pavucontrol rofi-wayland satty slurp swayidle swaylock  
    swaynotificationcenter swww transmission-gtk tree ungoogled-chromium virtualboxKvm 
    wayshot zed-editor 

    # create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: (
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses
          rust-analyzer
          rustc cargo 
        ])
      );
      profile = "export FHS=1";
      runScript = "zsh";
      extraOutputsToInstall = ["dev"];
    }))

    
    
# nodejs  rustc cargo are needed by nvim plugins
    # discord obs-studio gnome.file-rollerimv mpv element-desktop gimp 
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    # Import Scripts
    (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    (import ./../scripts/task-waybar.nix { inherit pkgs; })
    # (import ./../scripts/squirtle.nix { inherit pkgs; })
    (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
      inherit username; inherit wallpaperGit; })
    (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    (import ./../scripts/theme-selector.nix { inherit pkgs; })
    (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ./../scripts/web-search.nix { inherit pkgs; })
    (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ./../scripts/anyrun-launcher.nix { inherit pkgs; })
    #(import ./../scripts/screenshootin.nix { inherit pkgs; })
    (import ./../scripts/NewScreenshootin.nix { inherit pkgs; })
    # (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; })
  ];
  programs.gh.enable = false;
}
