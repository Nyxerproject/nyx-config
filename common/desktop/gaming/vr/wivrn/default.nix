{
  pkgs,
  inputs,
  ...
}: {
  services.wivrn = {
    enable = false;
    openFirewall = true;
    autoStart = false;
    defaultRuntime = false;
    config = {
      enable = false;
      json = {
        scale = 0.7;
        bitrate = 1000000000;
        # encoders = [
        #   {
        #     encoder = "nvenc";
        #     codec = "h264";
        #     width = 1.0;
        #     height = 1.0;
        #     offset_x = 0.0;
        #     offset_y = 0.0;
        #   }
        # ];
      };
    };
    package = inputs.lemonake.packages.${pkgs.system}.wivrn.override {
      cudaSupport = true;
      ovrCompatSearchPaths = "${pkgs.xrizer}/lib/xrizer";
    };
    monadoEnvironment = {
      WIVRN_USE_STEAMVR_LH = "1";
      LH_DISCOVER_WAIT_MS = "6000";
    };
  };
  networking.firewall.allowedUDPPorts = [5353];
  environment.systemPackages = with pkgs; [
    android-tools
    motoc
  ];
}
