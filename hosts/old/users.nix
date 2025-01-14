{
  pkgs,
  username,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
      ];
      shell = pkgs.nushell;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        anytype
        neovim
        devbox
        keepassxc
        just
        joplin-desktop
        gcc
        peazip
        zellij
        floorp
        vesktop
        firefox-devedition-bin-unwrapped
        libreoffice
        nemo
        pragtical
        remmina
        dig
        # create a fhs environment by command `fhs`, so we can run non-nixos packages in nixos!
        (
          let
            base = pkgs.appimageTools.defaultFhsEnvArgs;
          in
          pkgs.buildFHSUserEnv (
            base
            // {
              name = "fhs";
              targetPkgs =
                pkgs:
                # pkgs.buildFHSUserEnv 只提供一个最小的 FHS 环境，缺少很多常用软件所必须的基础包
                # 所以直接使用它很可能会报错
                #
                # pkgs.appimageTools 提供了大多数程序常用的基础包，所以我们可以直接用它来补充
                (base.targetPkgs pkgs)
                ++ (with pkgs; [
                  pkg-config
                  ncurses
                  # 如果你的 FHS 程序还有其他依赖，把它们添加在这里
                ]);
              profile = "export FHS=1";
              runScript = "bash";
              extraOutputsToInstall = [ "dev" ];
            }
          )
        )
      ];
    };
    # "newuser" = {
    #   homeMode = "755";
    #   isNormalUser = true;
    #   description = "New user account";
    #   extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    #   shell = pkgs.bash;
    #   ignoreShellProgramCheck = true;
    #   packages = with pkgs; [];
    # };
  };
}
