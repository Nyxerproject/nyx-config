{pkgs, ...}: {
  environment.systempackages = with pkgs; [
    super-slicer-beta
  ];
}
