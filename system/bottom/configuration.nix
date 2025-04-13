{pkgs, ...}: {
  networking.hostName = "bottom";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services = {
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    displayManager.defaultSession = "niri";
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
  };
  hardware.graphics = {
    enable = true;
    extraPackages = [pkgs.nvidia-vaapi-driver];
  };
  hardware.nvidia.open = true;
  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "module_blacklist=amdgpu"
  ];
  # environment.systemPackages = with pkgs; [
  #   cudaPackages.cudatoolkit-legacy-runfile # for Wivrn?
  # ];
}
