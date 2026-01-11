{
  config,
  pkgs,
  ...
}:
{
  imports = [ ./wivrn ];
  environment.systemPackages = with pkgs; [
    opencomposite
    index_camera_passthrough
    xrgears
    vrcx
    wlx-overlay-s
    wayvr-dashboard
    stardust-xr-server
    stardust-xr-gravity
    stardust-xr-magnetar
    stardust-xr-flatland
    stardust-xr-protostar
  ];
  # home-manager.users.nyx.
  # programs.xdg.enable = true;
  # home-manager.users.nyx.xdg.configFile."openvr/openvrpaths.vrpath".text = ''
  #   {
  #     "config" :
  #     [
  #       "${config.home-manager.users.nyx.xdg.dataHome}/Steam/config"
  #     ],
  #     "external_drivers" : null,
  #     "jsonid" : "vrpathreg",
  #     "log" :
  #     [
  #       "${config.home-manager.users.nyx.xdg.dataHome}/Steam/logs"
  #     ],
  #     "runtime" :
  #     [
  #       "${pkgs.opencomposite}/lib/opencomposite"
  #     ],
  #     "version" : 1
  #   }
  # '';
}
