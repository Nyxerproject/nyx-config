{
  pkgs,
  inputs,
  ...
}: {
  networking.hostName = "bottom";
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  nixpkgs.config.cudaSupport = true;
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
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = [inputs.lemonake.packages.${pkgs.system}.monado-vulkan-layers-git];
  hardware.nvidia.open = true;
  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "module_blacklist=amdgpu"
  ];
  # environment.systemPackages = with pkgs; [
  #   cudaPackages.cudatoolkit-legacy-runfile # for Wivrn?
  # ];
}
