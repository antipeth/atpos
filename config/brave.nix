{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    commandLineArgs = [
      "--ozone-platform-hint=auto"
      "--ozone-platform=wayland"
      "--gtk-version=4"
      "--enable-wayland-ime"
      "--password-store=basic"
    ];
    extensions = [
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
        # Cookie-Editor
        id = "hlkenndednhfkekhgcdicdfddnkalmdm";
      }
      {
        # Wappalyzer - Technology profiler
        id = "gppongmhjkpfnbhagpmjfkannfbllamg";
      }
      {
        # LocalCDN
        id = "njdfdhgcmkocbgbhcioffdbicglldapd";
      }
      {
        # uBlock Origin
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
      {
        # ClearURLs
        id = "lckanjgmijmafbedllaakclkaicjfmnk";
      }
    ];
  };
}
