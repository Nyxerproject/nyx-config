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
  ];
}
