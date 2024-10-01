{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ../../users/nyx.nix
    ./hardware-configuration.nix
    ../common/desktop/vr
    ../common/desktop/niri
    ../common/desktop
    ../common/desktop/gaming.nix
    ../common/zram.nix
    ../common
  ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "bottom";
  };

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;

    kernelParams = [
      "nvidia_drm.fbdev=1"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  chaotic.scx.enable = true; # by default uses scx_rustland scheduler
  chaotic.scx.scheduler = "scx_qmap";
  #chaotic.scx.scheduler = "scx_rusty";

  services = {
    desktopManager.plasma6.enable = true;
    # there is an issue with the theme and qt6 vs qt5.
    # TODO fix: https://github.com/NixOS/nixpkgs/issues/292761
    displayManager = {
      defaultSession = "plasma";
    };
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
    printing.enable = true;
    openssh.enable = true;
    tailscale.enable = true;
  };

  home-manager = {
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nyx = import ../../home/nyx/bottom;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = let
        monadoVulkanLayer = import inputs.monadoVulkanLayer {
          config.allowUnfree = true;
          system = "x86_64-linux"; # TODO there is prob a better way of declaring this
        };
      in [monadoVulkanLayer.monado-vulkan-layers];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  programs.fish.enable = true;

  # TODO make a seporate packages file
  environment.systemPackages = with pkgs; [
    corectrl
    qbittorrent
    ungoogled-chromium
    vlc
    cudaPackages.cudatoolkit-legacy-runfile
    mpv
  ];

  environment.sessionVariables = {
    FLAKE = "/home/nyx/nyx-config";
  };

  system.stateVersion = "24.05"; #DONT TOUCH!
}
