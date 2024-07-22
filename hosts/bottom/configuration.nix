{
  config,
  monadoVulkanLayer,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common/desktop/vr
    ../common/desktop
    ../common/desktop/gaming.nix
    ../common/zram.nix
    ../common
    # ./graphics.nix
  ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "bottom"; # Define your hostname.
  };

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  users.users.nyx = {
    isNormalUser = true;
    description = "nyx";
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$y$j9T$d2moNWhXMPaPXQQlBS9J7/$uQKwf.Y0xRKzbaOZCFybnrUeqB3HAnUiuzL17wA7/P3";
  };

  services = {
    desktopManager.plasma6.enable = true;
    xserver.enable = true;
    displayManager = {
      defaultSession = "plasma";
      sddm.wayland.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "nyx";
    };
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  services.openssh.enable = true;
  services.tailscale.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = [monadoVulkanLayer.monado-vulkan-layers];
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = false;
      finegrained = false;
    };
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.systemPackages = with pkgs; [
    alacritty
    corectrl
  ];

  programs.fish.enable = true;

  environment.sessionVariables = {
    FLAKE = "/home/nyx/nyx-config";
    MOZ_ENABLE_WAYLAND = 0; # TODO move to firefox.nix
  };

  system.stateVersion = "24.05"; #DONT TOUCH!
}
