{pkgs, ...}: {
  environment.systempackages = with pkgs; [
    prusa-slicer
  ];
}
