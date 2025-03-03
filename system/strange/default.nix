{
  imports = [
    ./configuration.nix
    ../../users/nyx.nix
    ../../common
    ../../common/wsl
    ./home.nix
  ];

  home-manager.users.nyx.imports = [];
}
