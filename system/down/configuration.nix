{pkgs, ...}: {
  networking.hostName = "down";

  boot.loader.grub.device = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBPNTY-512G-1006_20204F801215_1"; # TODO: remove this pls

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [vpl-gpu-rt];
  };

  services.xserver.enable = true;

  system.stateVersion = "24.05";
}
