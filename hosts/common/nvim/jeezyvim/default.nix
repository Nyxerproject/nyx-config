{
  inputs,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
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
