{
  imports = [
    ./configuration.nix
    ./disko-config.nix
    ../../users/nyx.nix
    ../../common
    ./home.nix
  ];

  home-manager.users.nyx.imports = [];
}
