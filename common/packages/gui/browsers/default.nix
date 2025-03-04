{pkgs, ...}: {
  programs.firefox.enable = true;
  home = {
    packages = with pkgs; [
      browsers
      ungoogled-chromium
      nyxt
    ];
  };
}
