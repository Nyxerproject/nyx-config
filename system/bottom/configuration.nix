{ pkgs, ... }:
{
  networking.hostName = "bottom";
  # boot.kernelPackages = pkgs.linuxPackages_cachyos;

  services = {
    scx = {
      enable = true;
      scheduler = "scx_rustland";
    };
    displayManager.defaultSession = "niri";
    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
    };
  };
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    podman-compose # start group of containers for dev
  ];

  hardware.graphics.enable = true;
  hardware.nvidia.open = true;
  boot.kernelParams = [
    "nvidia_drm.fbdev=1"
    "module_blacklist=amdgpu"
  ];
  nixpkgs.config.cudaSupport = true;
}
