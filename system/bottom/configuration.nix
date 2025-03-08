{
  networking.hostName = "bottom";
  services = {
    scx = {
      enable = true;
      scheduler = "scx_rusty";
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
  # environment.systemPackages = with pkgs; [
  # cudaPackages.cudatoolkit-legacy-runfile # for Wivrn?
  # ];
}
