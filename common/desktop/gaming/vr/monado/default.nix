{
  pkgs,
  config,
  ...
}: {
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
    XRT_COMPOSITOR_FORCE_WAYLAND_DIRECT = "1";
  };

  services = {
    monado = {
      enable = true;
      defaultRuntime = true;
    };
  };
  home-manager.users.nyx.xdg.configFile = {
    "openxr/1/active_runtime.json".source = "${pkgs.monado}/share/openxr/1/openxr_monado.json";

    "openvr/openvrpaths.vrpath".text = ''
      {
        "config" :
        [
          "${config.home-manager.users.nyx.xdg.dataHome}/Steam/config"
        ],
        "external_drivers" : null,
        "jsonid" : "vrpathreg",
        "log" :
        [
          "${config.home-manager.users.nyx.xdg.dataHome}/Steam/logs"
        ],
        "runtime" :
        [
          "${pkgs.opencomposite}/lib/opencomposite"
        ],
        "version" : 1
      }
    '';
  };
}
