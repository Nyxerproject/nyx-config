{pkgs, ...}: {
  imports = [
    ./notifications
    ./fuzzel.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      niri
    ];
  };
  programs.niri.enable = true;
}
