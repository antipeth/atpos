{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    browser wallpaperDir wallpaperGit flakeDir;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}" libvirt swww slurp kitty 
    swaynotificationcenter rofi-wayland imv transmission-gtk 
    pavucontrol tree 
    font-awesome swayidle swaylock firefox-devedition 
    betterbird brave   # lldb rust-analyzer 
    anytype bitwarden
    telegram-desktop element-desktop libreoffice keepassxc yarn ungoogled-chromium
    ghostwriter atuin just gitui wayshot satty copyq
    zed-editor virtualboxKvm discord gopass
    # rustc cargo clang-tools clang jdk17 python3 go grim 

    # create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!
    (let base = pkgs.appimageTools.defaultFhsEnvArgs; in
      pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs: (
        # pkgs.buildFHSUserEnv 只提供一个最小的 FHS 环境，缺少很多常用软件所必须的基础包
        # 所以直接使用它很可能会报错
        #
        # pkgs.appimageTools 提供了大多数程序常用的基础包，所以我们可以直接用它来补充
        (base.targetPkgs pkgs) ++ (with pkgs; [
          pkg-config
          ncurses
          rust-analyzer
          rustc cargo 
          # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
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
