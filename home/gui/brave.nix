{pkgs, ...}: {
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--wayland-text-input-version=3"
      "--password-store=basic"
    ];
    extensions = [
      {
        # ClearURLs
        id = "lckanjgmijmafbedllaakclkaicjfmnk";
      }
      {
        # Cookie-Editor
        id = "hlkenndednhfkekhgcdicdfddnkalmdm";
      }
      {
        # Dark Reader
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";
      }
      {
        # KeePassXC-Browser
        id = "oboonakemofpalcgghocfoadofidjkkk";
      }
      {
        # kiss-translator
        id = "bdiifdefkgmcblbcghdlonllpjhhjgof";
      }
      {
        # LocalCDN
        id = "njdfdhgcmkocbgbhcioffdbicglldapd";
      }
      {
        # MetaMask
        id = "nkbihfbeogaeaoehlefnkodbefgpgknn";
      }
      {
        # uBlock Origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      {
        # User-Agent Switcher and Manager
        id = "bhchdcejhohfmigjafbampogmaanbfkg";
      }
      {
        # Vimium C
        id = "hfjbmagddngcpeloejdejnfgbamkjaeg";
      }
      {
        # Violentmonkey
        id = "jinjaccalgkegednnccohejagnlnfdag";
      }
      {
        # Wappalyzer - Technology profiler
        id = "gppongmhjkpfnbhagpmjfkannfbllamg";
      }
    ];
  };
}
