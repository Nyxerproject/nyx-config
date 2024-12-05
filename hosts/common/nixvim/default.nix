{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./config
    inputs.nixvim.nixosModules.nixvim
  ];

  programs.nixvim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraConfigLua = ''
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      require('lspconfig').markdown_oxide.setup({
        on_attach = _M.lspOnAttach,
        capabilities = "vim.tbl_deep_extend( 'force', capabilities or {}, { workspace = { didChangeWatchedFiles = { dynamicRegistration = true, }, }, })"
      })
    '';
  };

  environment = {
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = with pkgs; [
      neovim
      tectonic # TODO: move tectonic elseware. it shouldn't be here
    ];
  };
}
