{pkgs, ...}: {
  environment.variables = {
    WIVRN_USE_STEAMVR_LH = 1;
    LH_DISCOVER_WAIT_MS = 6000;
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
