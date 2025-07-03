{pkgs, ...}: {
  networking.hostName = "bottom";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  services = {
    scx = {
      enable = true;
      scheduler = "scx_rustland";
    };
    displayManager.defaultSession = "niri";
    xserver.videoDrivers = ["nvidia"];
  };
  hardware = {
    nvidia.open = true;
    graphics.enable = true;
  };
  boot.kernelParams = [
    # "nvidia_drm.fbdev=1"
    "module_blacklist=amdgpu"
  ];
  # nixpkgs.config.cudaSupport = true;
}
