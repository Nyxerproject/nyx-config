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
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services = {
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
    };
    displayManager = {defaultSession = "plasma";};
    printing.enable = true;
    openssh.enable = true;
    tailscale.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = let
        monadoVulkanLayer = import inputs.monadoVulkanLayer {
          config.allowUnfree = true;
          system = "x86_64-linux";
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
