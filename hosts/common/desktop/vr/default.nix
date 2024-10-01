{
  pkgs,
  inputs,
  ...
}: {
  imports = [./wivrn ./monado];

  environment.variables = {
    LH_DEFAULT_BRIGHTNESS = 1;
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
    #LIBMONADO_PATH = "${pkgs.monado}/lib/libmonado.so";
    LIBMONADO_PATH = "${pkgs.wivrn}/lib/libmonado.so";
    # U_PACING_APP_IMMEDIATE_WAIT_FRAME_RETURN = "1";
    # U_PACING_APP_USE_MIN_WAKE_PERIOD = "1";
    # U_PACING_COMP_MIN_TIME_MS = "4";
    WIVRN_USE_STEAMVR_LH = 1;
    LH_DISCOVER_WAIT_MS = 6000;
  };

  programs.envision.enable = true;
  services = {
    monado = {
      enable = true;
      #defaultRuntime = true;
    };

    wivrn = {
      openFirewall = true;
      defaultRuntime = true;
      #package = inputs.lemonake.packages.x86_64-linux.wivrn;
    };
  };

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
