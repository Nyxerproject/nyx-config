{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./disko-config.nix
    ../common/desktop
    ../common
  ];

  # filesystems, disks, and bootloading
  boot.loader.grub = { 
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    device = "/dev/disk/by-id/nvme-WDC_PC_SN730_SDBPNTY-512G-1006_20204F801215_1";
    # device = disko.devices.disk.main.devices; # or something like that. idk, im bad at nix
  };

  # hardware.enableRedistributableFirmware = lib.mkDefault true;
  # hardware stuff # TODO move hardware to seporate nix file
  hardware.bluetooth.enable = true; # this can prob be removed with the addition of an applet

  # networking
  networking = {
    hostName = "down";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # localization # TODO move to seporate nix file
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  services = { # services and background things
    xserver = { # display things
      enable = true;
    };
    displayManager = {
      autoLogin.user = "nyx"; # login things
    };
    printing.enable = true; # printing
    openssh.enable = true; # networking things
    tailscale.enable = true;

    pipewire = { # sound stuff
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  # bloat?
  #security.rtkit.enable = true;

  users.users.nyx = { # TODO move to seporate nix file (module?)
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
    hashedPassword = "$y$j9T$d2moNWhXMPaPXQQlBS9J7/$uQKwf.Y0xRKzbaOZCFybnrUeqB3HAnUiuzL17wA7/P3";
  };

  environment.systemPackages = with pkgs; [ # TODO creat
    neovim
    lunarvim
    niri
    git
    wget
    alacritty
    rio
    fuzzel
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.05";
}
