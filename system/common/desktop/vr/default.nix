{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./wivrn
    ./monado
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];

  environment.systemPackages = with pkgs; [
    opencomposite
    index_camera_passthrough
    wlx-overlay-s
    xrgears
    stardust-xr-server
    stardust-xr-kiara
    stardust-xr-gravity
    stardust-xr-magnetar
    stardust-xr-flatland
    stardust-xr-sphereland
    stardust-xr-phobetor
    stardust-xr-atmosphere
    stardust-xr-protostar
  ];
}
