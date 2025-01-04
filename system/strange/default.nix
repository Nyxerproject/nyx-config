{
  imports = [
    ./configuration.nix
    ../../users/nyx.nix
    ../../common
    ../../common/wsl.nix
    ./home.nix
  ];

  home-manager.users.nyx.imports = [];
}
