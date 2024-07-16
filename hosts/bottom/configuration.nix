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

  # Enable the X11 windowing system.
  services = {
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb = {
        # Configure keymap in X11
        layout = "us";
        variant = "";
      };
    };
    displayManager = {
      defaultSession = "plasma";
      sddm.wayland.enable = true;
      #lemurs.enable = true;
    };
    # Enable CUPS to print documents.
    printing.enable = true;
  };

  # Enable sound with pipewire.
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true; # If you want to use JACK applications, uncomment this

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  users.users.nyx = {
    isNormalUser = true;
    description = "nyx";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
      htop
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "nyx";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # hardware.graphics = {
  # enable = true;
  # enable32Bit = true;
  # extraPackages = [pkgsmndvlknlyrs.monado-vulkan-layers];
  # };
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

  # this should get moved
  # nyx-rebuild = pkgs.writeShellScriptBin "nyx-rebuild" /* bash */ ''
  # nyx-rebuild = pkgs.writers.writeBashBin "nyx-rebuild"  /* bash */ ''
  # pkgs.writeShellApplication {
  #   name = "nyx-rebuild";
  #   text =
  #     /*
  #     bash
  #     */
  #     ''
  # };

  # List packages installed in system profile. To search, run:
  services.tailscale.enable = true;
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zlib
    lunarvim
    alacritty
    wget
    git
    corectrl

    # nixos stuff
    alejandra
    nix-output-monitor
    nh
    nvd
    comma
    nix-health
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

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
    MOZ_ENABLE_WAYLAND = 0;
  };

  # List services that you want to enable:
  services.openssh.enable = true;

  system.stateVersion = "23.11"; #DONT TOUCH!

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
