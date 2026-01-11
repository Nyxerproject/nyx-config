{ pkgs, ... }:
{
  programs.firefox.enable = true;
  home = {
    packages = with pkgs; [
      # browsers
      # brave
      ungoogled-chromium
      # nyxt
    ];
  };
}
