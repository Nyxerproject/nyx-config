{
  config,
  pkgs,
  ...
}: {
  imports = [./wivrn ./monado];
  environment.systemPackages = with pkgs; [
    opencomposite
    index_camera_passthrough
    wlx-overlay-s
    xrgears
    eepyxr
    vrcx
    wayvr-dashboard
    stardust-xr-server
    stardust-xr-kiara
    stardust-xr-gravity
    stardust-xr-magnetar
    stardust-xr-flatland
    stardust-xr-phobetor
    stardust-xr-protostar
    stardust-xr-atmosphere
    stardust-xr-sphereland
  ];
}
