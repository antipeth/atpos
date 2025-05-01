{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    enableMan = false;
    imports = [
      ./autocmd.nix
      ./keymaps.nix
      ./settings.nix
      ./lazy.nix
      ./plugins
    ];
    extraPackages = with pkgs; [
      ripgrep
      lazygit
      fzf
      fd
      wakatime-cli
    ];
  };
}
