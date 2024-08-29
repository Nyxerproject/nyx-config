{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      jeezyvim
    ];
  };
}
