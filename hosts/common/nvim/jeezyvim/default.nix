{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    extraConfigLua = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      require('lspconfig').markdown_oxide.setup({
        on_attach = _M.lspOnAttach,
        capabilities = "vim.tbl_deep_extend( 'force', capabilities or {}, { workspace = { didChangeWatchedFiles = { dynamicRegistration = true, }, }, })"
      })
    '';
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
