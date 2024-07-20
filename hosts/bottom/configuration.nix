{
  config,
  inputs,
  system,
  monadoVulkanLayer,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common/desktop/vr
    ../common/desktop/gaming.nix
    ../common/desktop/mullvad.nix
    ../common/desktop
    ../common
    # ./graphics.nix
  ];

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "bottom"; # Define your hostname.
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  zramSwap.enable = true;
  zramSwap.memoryPercent = 200;

  boot.extraModprobeConfig = ''
    # Fix Nintendo Switch Pro Controller disconnects
    options bluetooth disable_ertm=1
  '';

  time.timeZone = "America/Chicago";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
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

  users.users.nyx = {
    isNormalUser = true;
    description = "nyx";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
    ];
    hashedPassword = "$y$j9T$d2moNWhXMPaPXQQlBS9J7/$uQKwf.Y0xRKzbaOZCFybnrUeqB3HAnUiuzL17wA7/P3";
  };

  nixpkgs.config.allowUnfree = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = [monadoVulkanLayer.monado-vulkan-layers];
  };

  services.xserver.videoDrivers = ["nvidia"];

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

  # List packages installed in system profile. To search, run:
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [
    alacritty
    corectrl
  ];

  programs.fish.enable = true;
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  programs.envision.enable = true;

  environment.sessionVariables = {
    FLAKE = "/home/nyx/nyx-config";
    EDITOR = "lvim";
    MOZ_ENABLE_WAYLAND = 0; # TODO move to firefox.nix
  };

  services.openssh.enable = true;

  system.stateVersion = "24.05"; #DONT TOUCH!

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
