{pkgs, ...}: {
  environment.variables = {
    LH_DEFAULT_BRIGHTNESS = 1;
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
    # U_PACING_APP_IMMEDIATE_WAIT_FRAME_RETURN = "1";
    # U_PACING_APP_USE_MIN_WAKE_PERIOD = "1";
    # U_PACING_COMP_MIN_TIME_MS = "4";
  };

  services = {
    monado = {
      enable = true;
      defaultRuntime = true;
    };
  };
}
