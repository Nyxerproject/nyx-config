{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libgcc
  ];
  programs.direnv.enable = true;
}
