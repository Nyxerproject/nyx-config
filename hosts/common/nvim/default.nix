{
  pkgs,
  inputs,
  ...
}: {
  imports = [./jeezyvim];

  environment.systemPackages = with pkgs; [
    neovim
    lunarvim
  ];
}
