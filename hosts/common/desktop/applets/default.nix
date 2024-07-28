{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      networkmanagerapplet
      blueman
    ];
  };
}
