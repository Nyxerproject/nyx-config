{
  environment.variables = {
    LH_DEFAULT_BRIGHTNESS = 1;
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };

  services = {
    monado = {
      enable = true;
      defaultRuntime = true;
    };
  };
}
