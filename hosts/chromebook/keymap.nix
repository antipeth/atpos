_: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            meta = "oneshot(alt)";
            leftalt = "oneshot(meta)";
          };
        };
      };
    };
  };
}
