{pkgs, ...}: {
  networking.hostName = "bottom";

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services = {
    scx = {
      enable = true;
      services.scx.scheduler = "scx_rusty";
    };
    displayManager.defaultSession = "niri";
    xserver.enable = true;
  };
  hardware.graphics.enable = true;

  # hardware.nvidia.open = true;
  # services.xserver.videoDrivers = ["nvidia"];
  # boot.kernelParams = ["nvidia_drm.fbdev=1"];

  # TODO: make a seporate packages file
  environment.systemPackages = with pkgs; [
    corectrl
    # cudaPackages.cudatoolkit-legacy-runfile # for Wivrn?
  ];
}
