{
  networking.hostName = "bottom";
  services = {
    scx = {
      enable = true;
      scheduler = "scx_rusty";
    };
    # displayManager.defaultSession = "niri";
    xserver.enable = true;
  };
  hardware.graphics.enable = true;
  # hardware.nvidia.open = true;
  # services.xserver.videoDrivers = ["nvidia"];
  # boot.kernelParams = ["nvidia_drm.fbdev=1"];
  boot.kernelParams = ["module_blacklist=amdgpu"];
  # environment.systemPackages = with pkgs; [
  # cudaPackages.cudatoolkit-legacy-runfile # for Wivrn?
  # ];
}
