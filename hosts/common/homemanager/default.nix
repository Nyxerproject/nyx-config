{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager = {
    enable = true;
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
