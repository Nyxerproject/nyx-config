{
  config,
  inputs,
  system,
  monadoVulkanLayer,
  pkgs,
  ...
}: let
  inherit system;
  monadoVulkanLayer = import inputs.monadoVulkanLayer {
    config.allowUnfree = true;
    inherit system;
  };
in {
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = [monadoVulkanLayer.monado-vulkan-layers];
  };
}
