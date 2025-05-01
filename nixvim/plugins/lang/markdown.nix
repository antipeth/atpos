{
  lib,
  pkgs,
  ...
}: {
  extraPackages = with pkgs; [
    marksman
  ];

  plugins = {
    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.wl-clipboard;
    };

    image = {
      enable = lib.nixvim.enableExceptInTests;
      settings.integrations.markdown = {
        clearInInsertMode = true;
        onlyRenderImageAtCursor = true;
      };
    };

    markdown-preview = {
      enable = true;
    };

    render-markdown = {
      enable = true;
    };

    lsp.servers = {
      marksman.enable = true;

      ltex = {
        enable = true;
        filetypes = [
          "markdown"
          "text"
        ];

        settings.completionEnabled = true;

        extraOptions = {
          checkFrequency = "save";
          language = "en-GB";
        };
      };
    };
    # markdownlint-cli2 have problems in build.
    # need to try a newer version in future,
    # lint = {
    #   lintersByFt.md = [ "markdownlint-cli2" ];
    #   linters.markdownlint-cli2.cmd = "${pkgs.markdownlint-cli2}/bin/markdownlint-cli2";
    # };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      action = "<cmd>MarkdownPreviewToggle<cr>";
      options = {
        silent = true;
        desc = "Toggle markdown preview";
      };
    }
  ];
}
