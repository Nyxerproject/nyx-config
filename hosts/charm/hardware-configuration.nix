{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];
  boot = {
    initrd = {
      #availableKernelModules = ["xhci_pci" "thunderbolt" "vmd" "nvme"];
      availableKernelModules = ["xhci_pci" "vmd" "nvme"];
      kernelModules = [];
    };
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
  };
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
