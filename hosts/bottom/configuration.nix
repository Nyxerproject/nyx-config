{
  config,
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

  zramSwap.enable = true;
  zramSwap.memoryPercent = 200;

  users.users.nyx = {
    isNormalUser = true;
    description = "nyx";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
    ];
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

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.05"; #DONT TOUCH!
}
