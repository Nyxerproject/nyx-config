{pkgs, ...}: {
  programs.firefox.enable = true;
  home = {
    packages = with pkgs; [
      browsers
      ungoogled-chromium
      nyxt
    ];
  };
  #environment.systemPackages = [inputs.zen-browser.packages."${system}".default];
}
