{pkgs, ...}:
{
  programs.password-store = {
    enable=true;
    package = pkgs.pass.withExtensions (exts: [
      exts.pass-import
      exts.pass-update
    ]);
  };
  programs.browserpass = {
    enable = true;
    browsers = [
      "brave"
      "chrome"
      "chromium"
      "firefox"
    ];
  };
}
