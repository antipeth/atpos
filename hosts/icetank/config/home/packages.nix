{ pkgs, config, username, ... }:

let 
  inherit (import ../../options.nix) 
    # browser wallpaperDir wallpaperGit flakeDir
    ;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    libvirt  
   rustc cargo jdk17 python3 go # lldb rust-analyzer 
     clang-tools clang bun deno 
     yarn 
      typescript lshw
    taplo rust-analyzer jdt-language-server nodePackages_latest.typescript-language-server
    lua-language-server stylua marksman 


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
          # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
        ])
      );
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = ["dev"];
    }))

    
    
    # nodejs  rustc cargo are needed by nvim plugins 
    # swww grim slurp kitty swaynotificationcenter rofi-wayland imv transmission-gtk 
    # audacity pavucontrol tree devbox spotify ungoogled-chromium
    # font-awesome swayidle swaylock firefox-devedition telegram-desktop element-desktop libreoffice marktext keepassxc
    # betterbird-unwrapped brave discord anytype bitwarden lapce
    # discord obs-studio gnome.file-rollerimv mpv element-desktop gimp 
    #  (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    #  Import Scripts
    #  (import ./../scripts/emopicker9000.nix { inherit pkgs; })
    # (import ./../scripts/task-waybar.nix { inherit pkgs; })
    #  (import ./../scripts/squirtle.nix { inherit pkgs; })
    # (import ./../scripts/wallsetter.nix { inherit pkgs; inherit wallpaperDir;
    #   inherit username; inherit wallpaperGit; })
    # (import ./../scripts/themechange.nix { inherit pkgs; inherit flakeDir; })
    # (import ./../scripts/theme-selector.nix { inherit pkgs; })
    # (import ./../scripts/nvidia-offload.nix { inherit pkgs; })
    # (import ./../scripts/web-search.nix { inherit pkgs; })
    # (import ./../scripts/rofi-launcher.nix { inherit pkgs; })
    # (import ./../scripts/screenshootin.nix { inherit pkgs; })
    #  (import ./../scripts/list-hypr-bindings.nix { inherit pkgs; })
  ];

  # programs.gh.enable = false;
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscodium.fhs;
  #   extensions = with pkgs.vscode-extensions; [
  #    #  ms-ceintl.vscode-language-pack-zh-hans
  #      formulahendry.code-runner
  #      ms-vscode.cpptools
  #    #  vadimcn.vscode-lldb
  #      vscodevim.vim
  #    #  rust-lang.rust-analyzer

  #    ];
  # };
}
