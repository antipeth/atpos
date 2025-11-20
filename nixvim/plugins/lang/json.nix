{pkgs, ...}: {
  plugins = {
    conform-nvim.settings = {
      formatters_by_ft = {
        json = ["jql"];
      };

      formatters = {
        jql = {
          command = "${pkgs.jql}/bin/jql";
        };
      };
    };

    # lint = {
    #   lintersByFt = {
    #     json = ["jsonlint"];
    #   };
    #
    #   linters = {
    #     jsonlint = {
    #       cmd = "${pkgs.nodePackages_latest.jsonlint}/bin/jsonlint";
    #     };
    #   };
    # };

    lsp.servers.jsonls = {
      enable = true;
    };
  };
}
