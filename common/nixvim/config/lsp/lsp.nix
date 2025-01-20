{pkgs, ...}: {
  plugins.lsp = {
    enable = pkgs.lib.mkDefault true;
    servers = {
      markdown_oxide.enable = pkgs.lib.mkDefault true;
      ltex.enable = pkgs.lib.mkDefault true;
      texlab.enable = pkgs.lib.mkDefault true;
      clangd.enable = pkgs.lib.mkDefault true;
      bashls.enable = pkgs.lib.mkDefault true;
      cmake.enable = pkgs.lib.mkDefault true;
      dockerls.enable = pkgs.lib.mkDefault true;
      gopls.enable = pkgs.lib.mkDefault true;
      omnisharp.enable = pkgs.lib.mkDefault true;
      jsonls.enable = pkgs.lib.mkDefault true;
      nil_ls.enable = pkgs.lib.mkDefault true;
      pyright.enable = pkgs.lib.mkDefault true;
      lua_ls.enable = pkgs.lib.mkDefault true;
      tinymist.enable = pkgs.lib.mkDefault true;
      cssls.enable = pkgs.lib.mkDefault true;
      html.enable = pkgs.lib.mkDefault true;
      yamlls.enable = pkgs.lib.mkDefault true;
      taplo.enable = pkgs.lib.mkDefault true;
    };
  };

  plugins.lsp-format.enable = pkgs.lib.mkDefault true;
}