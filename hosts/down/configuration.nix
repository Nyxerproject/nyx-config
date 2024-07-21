{
  lib,
  pkgs,
  ...
}: {
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
    # TODO fix and remove this. disko should automatically set this
  };

  # networking
  networking = {
    hostName = "down";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  # services and background things
  services = {
    # display things
    xserver = {
      enable = true;
    };
    displayManager = {
      autoLogin.enable = false;
      autoLogin.user = "nyx"; # login things
      sddm = {
        enable = true;
        wayland.enable = true;
        sugarCandyNix = {
          enable = true; # set SDDM's theme to "sddm-sugar-candy-nix".
          settings = {
            Background = lib.cleanSource ../common/theme/backgrounds/background.png;
            ScreenWidth = 1920;
            ScreenHeight = 1080;
            FormPosition = "left";
            HaveFormBackground = true;
            PartialBlur = true;
          };
        };
      };
    };
    printing.enable = true; # printing
    openssh.enable = true; # networking things
    tailscale.enable = true;

    # sound stuff
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  users.users.nyx = {
    # TODO move to seporate nix file (module?)
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel"];
    hashedPassword = "$y$j9T$d2moNWhXMPaPXQQlBS9J7/$uQKwf.Y0xRKzbaOZCFybnrUeqB3HAnUiuzL17wA7/P3";
  };

  environment = {
    systemPackages = with pkgs; [
      # TODO creat
      neovim
      lunarvim
      niri
      git
      wget
      alacritty
      rio
      fuzzel
    ];
    sessionVariables = {
      FLAKE = "/home/nyx/nyx-config";
      EDITOR = "lvim";
    };
  };

  programs = {
    fish.enable = true;
    neovim = {
      # TODO remove with nixvim update
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  system.stateVersion = "24.05";
}
