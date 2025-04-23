{pkgs, ...}: {
  networking.hostName = "down";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services = {
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
  boot.loader.grub.device = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBPNTY-512G-1006_20204F801215_1";
  services.xserver.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [vpl-gpu-rt];
  };
  # specialisation.android-tools.configuration = {
  #   imports = [../../common/packages/cli/android-tools];
  # };
}
