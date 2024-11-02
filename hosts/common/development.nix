{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    libgcc
  ];
}
