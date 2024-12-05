{inputs, ...}: {
  environment.variables = {
    WIVRN_USE_STEAMVR_LH = 1;
    LH_DISCOVER_WAIT_MS = 6000;
  };
  services = {
    wivrn = {
      enable = true;
      openFirewall = true;
      defaultRuntime = true;
      package = inputs.lemonake.packages.x86_64-linux.wivrn;
    };
  };
}
