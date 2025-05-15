{pkgs, ...}: {
  networking.hostName = "bottom";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  services = {
    scx = {
      enable = true;
      scheduler = "scx_rustland";
    };
    displayManager.defaultSession = "niri";
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
  };
  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "module_blacklist=amdgpu"
  ];
  nixpkgs.config.cudaSupport = true;
}
