{pkgs, ...}: {
  imports = [./jeezyvim];

  programs.neovim = {
    # defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  environment = {
    sessionVariables = {
      EDITOR = "nvim";
    };
    systemPackages = with pkgs; [
      neovim
      tectonic
      lunarvim
      dotnetCorePackages.dotnet_8.sdk # for c sharp lsp
    ];
  };

  #extraConfigLua = "require('my-plugin').setup({foo = "bar"})";
}
