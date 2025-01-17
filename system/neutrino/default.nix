{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./disko-config.nix
    ../../users/nyx.nix
    ../../common
    ./home.nix
    ../../common/nixvim
    ../../common/nix
    ../../common/localization.nix
    ../../common/security
    ../../common/scripts.nix
    ../../common/tailscale.nix
    ../../common/ssh.nix

    ../../common/packages.nix
    ../../common/development.nix
    ../../common/theme
    ../../common/homemanager
  ];

  home-manager.users.nyx.imports = [];
}
