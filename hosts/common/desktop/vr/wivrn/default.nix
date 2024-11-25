{pkgs, ...}: {
  environment.variables = {
    WIVRN_USE_STEAMVR_LH = 1;
    LH_DISCOVER_WAIT_MS = 6000;
    # LH_DEFAULT_BRIGHTNESS = 1;
    # U_PACING_APP_IMMEDIATE_WAIT_FRAME_RETURN = "1";
    # U_PACING_APP_USE_MIN_WAKE_PERIOD = "1";
    # U_PACING_COMP_MIN_TIME_MS = "4";
  };

  services = {
    wivrn = {
      enable = true;
      openFirewall = true;
      autoStart = true;
      defaultRuntime = true;
    };
  };

  environment.systemPackages = with pkgs; [
    sidequest
    android-tools
    motoc
  ];
}
