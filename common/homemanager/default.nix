{inputs, ...}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    users.nyx.imports = [../home];
    backupFileExtension = "backup";
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
