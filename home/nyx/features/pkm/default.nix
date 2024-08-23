{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.markdown-oxide
  ];
}
