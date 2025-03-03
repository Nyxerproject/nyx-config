{pkgs, ...}: {
  imports = [./wivrn];
  environment.systemPackages = with pkgs; [
    opencomposite
    index_camera_passthrough
    wlx-overlay-s
    xrgears
    stardust-xr-server
    stardust-xr-gravity
    stardust-xr-magnetar
    stardust-xr-flatland
    stardust-xr-protostar
  ];
}
