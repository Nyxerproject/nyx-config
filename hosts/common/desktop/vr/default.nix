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
    sidequest
    android-tools
    motoc
    wivrn
    opencomposite
    index_camera_passthrough
    monado
    libsurvive
    wlx-overlay-s
    xrgears
  ];
}
