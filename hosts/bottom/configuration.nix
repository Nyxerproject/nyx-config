{
  config,
  inputs,
  pkgsmndvlknlyrs,
  system ? builtins.currentSystem,
  pkgs,
  ...
}: let
  nyx-rebuild =
    pkgs.writers.writeBashBin "nyx-rebuild" {}
    /*
    bash
    */
    ''
      #!/usr/bin/env bash

      # A rebuild script that commits on a successful build
      set -e

      # Edit your config
      $EDITOR ~/nyx-config/

      # cd to your config dir
      pushd ~/nyx-config/

      # Early return if no changes were detected (thanks @singiamtel!)
      #if git diff --cached --quiet HEAD -- '*.nix'; then
      if git diff --quiet HEAD -- '*.nix'; then
          echo "No changes detected, exiting."
          popd
          exit 0
      fi

      # Autoformat your nix files
      alejandra . &>/dev/null \
        || ( alejandra . ; echo "formatting failed!" && exit 1)

      # Shows your changes
      git diff -U0 '*.nix'

      echo "NixOS Rebuilding..."

      # Rebuild, output simplified errors, log trackebacks
      sudo nixos-rebuild switch --flake .#bottom &>nixos-switch.log || (cat nixos-switch.log | grep --color error && exit 1)

      # Get current generation metadata
      current=$(nixos-rebuild list-generations | grep current)

      # Commit all changes witih the generation metadata
      git commit -am "$current"

      # Back to where you were
      popd

      # Notify all OK!
      notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
    '';
in {
  imports = [
    ./hardware-configuration.nix
    ../common/desktop
    ../common
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = "bottom"; # Define your hostname.
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

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
    # services.desktopManager.plasma6.enable = true;
    xserver = {
      desktopManager.plasma5.enable = true;
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
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
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
    extraPackages = [pkgsmndvlknlyrs.monado-vulkan-layers];
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
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zlib
    lunarvim
    alacritty
    wget
    git

    # nixos stuff
    alejandra
    nix-output-monitor
    nh
    nvd
    comma
    nix-health
    nyx-rebuild
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

  environment.variables.EDITOR = "lvim";
  environment.sessionVariables = {
    FLAKE = "/home/nyx/nyx-config";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
