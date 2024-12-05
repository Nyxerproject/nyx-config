{
  environment.variables = {
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
