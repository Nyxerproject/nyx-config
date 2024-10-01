{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;

    extraPackages = [pkgs.markdown-oxide];
    extraConfigLua = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      require('lspconfig').markdown_oxide.setup({
        on_attach = _M.lspOnAttach,
        capabilities = "vim.tbl_deep_extend( 'force', capabilities or {}, { workspace = { didChangeWatchedFiles = { dynamicRegistration = true, }, }, })"
      })
    '';

    plugins.cmp.settings.completion.keyword_pattern = "[[\(\k\| \|\/\|#\)\+]]";
  };
  nixpkgs = {
    overlays = [
      inputs.jeezyvim.overlays.default
    ];
  };
  environment.systemPackages = with pkgs; [
    jeezyvim
  ];
}
