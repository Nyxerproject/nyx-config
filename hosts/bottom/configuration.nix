{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "bottom";

  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    kernelParams = ["nvidia_drm.fbdev=1"];
  };

  services.scx = {
    enable = true;
    services.scx.scheduler = "scx_rusty";
  };

  services = {
    desktopManager.plasma6.enable = true;
    # TODO: https://github.com/NixOS/nixpkgs/issues/292761
    displayManager = {
      defaultSession = "niri";
    };
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
  };

  home-manager.users.nyx = import ../../home/nyx/bottom;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  programs.fish.enable = true;

  # TODO: make a seporate packages file
  environment.systemPackages = with pkgs; [
    corectrl
    ungoogled-chromium
    obs-studio
    kooha
    vlc
    #cudaPackages.cudatoolkit-legacy-runfile
    mpv
  ];

  system.stateVersion = "24.05"; #DONT TOUCH!
}
