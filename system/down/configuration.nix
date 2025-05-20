{
  pkgs,
  inputs,
  ...
}: {
  networking.hostName = "down";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx = {
    enable = true;
    scheduler = "scx_rustland";
  };

  boot.loader.grub.device = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBPNTY-512G-1006_20204F801215_1";
  services.xserver.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vpl-gpu-rt
    ];
  };
}
