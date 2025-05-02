{pkgs,...}: {
  dconf = {
    enable = true;
    settings={
      "org/gnome/shell" = {
        disable-user-extensions = false; # enables user extensions
        enabled-extensions = [
          pkgs.gnomeExtensions.gsconnect.extensionUuid
        ];
    };
  };
}
