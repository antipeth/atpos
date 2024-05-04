{pkgs, lib, config, ...}:
let 
  passwordStoreDir = "~/.local/share/password-store";
in {
    programs.password-store = {
        enable=true;
        package = pkgs.pass.withExtensions (exts: [
          exts.pass-import
          exts.pass-update
        ]);
    settings = {
      PASSWORD_STORE_DIR = passwordStoreDir;
      # Overrides the default gpg key identification set by init.
      # Hexadecimal key signature is recommended.
      # Multiple keys may be specified separated by spaces.
      PASSWORD_STORE_KEY = lib.strings.concatStringsSep " " [
        "EF824EB73CFD6CC7" # E - Ryan Yin (For pass & ssh only) <ryan4yin@linux.com>
      ];
      # all .gpg-id files and non-system extension files must be signed using a detached signature using the GPG key specified by
      #   the full 40 character upper-case fingerprint in this variable.
      # If multiple fingerprints are specified, each separated by a whitespace character, then signatures must match at least one.
      # The init command will keep signatures of .gpg-id files up to date.
      PASSWORD_STORE_SIGNING_KEY = lib.strings.concatStringsSep " " [
        "C2A313F98166C942" # S - Ryan Yin (For pass & ssh only) <ryan4yin@linux.com>
      ];
      PASSWORD_STORE_CLIP_TIME = "60";
      PASSWORD_STORE_GENERATED_LENGTH = "15";
      PASSWORD_STORE_ENABLE_EXTENSIONS = "true";
    };
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
