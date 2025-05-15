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

  environment.systemPackages = [
    # inputs.zed-editor.packages.${pkgs.system}.zed-editor-bin-fhs
    (inputs.zed-editor.packages.x86_64-linux.zed-editor-bin.override {
      overrideVersion = "0.187.1-pre";

      overrideHash = "sha256-dGVDixRJQcWUeDuzZHY+B7sKnNJzlUXXhVM8W85YrHI=";
    })
  ];

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
