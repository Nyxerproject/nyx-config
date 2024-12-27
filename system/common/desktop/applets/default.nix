{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      networkmanagerapplet
      cosmic-applets
      blueman
    ];
  };
}
