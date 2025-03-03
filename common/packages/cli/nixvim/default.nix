{
  programs.nixvim = {
    enable = true;
    imports = [./config];
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
  environment = {
    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
