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

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  chaotic.scx.enable = true; # by default uses scx_rustland scheduler
  chaotic.scx.scheduler = "scx_rusty";

  services = {
    desktopManager.plasma6.enable = true;
    # there is an issue with the theme and qt6 vs qt5.
    # TODO fix: https://github.com/NixOS/nixpkgs/issues/292761
    displayManager = {
      defaultSession = "niri";
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
    opengl = {
      enable = true;
      driSupport32Bit = true;
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
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  programs.fish.enable = true;

  # TODO make a seporate packages file
  environment.systemPackages = with pkgs; [
    corectrl
  ];

  environment.sessionVariables = {
    FLAKE = "/home/nyx/nyx-config";
    MOZ_ENABLE_WAYLAND = 0; # TODO move to firefox.nix
  };

  system.stateVersion = "24.05"; #DONT TOUCH!
}
