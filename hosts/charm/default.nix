{pkgs, ...}: {
  networking.hostName = "charm";

  boot.loader.grub.device = "/dev/disk/by-id/::<>"; # hehe, terbofish

  #hardware.opengl = {enable = true;};

  #services.xserver.enable = true;
  home-manager.users.nyx = import ../../home/nyx/charm;

  system.stateVersion = "24.05";
}
