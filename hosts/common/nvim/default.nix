{
  pkgs,
  inputs,
  ...
}: {
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
      lunarvim
    ];
  };
}
