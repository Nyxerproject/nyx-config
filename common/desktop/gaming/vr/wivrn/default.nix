{
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services = {
    wivrn = {
      enable = false;
      openFirewall = true;
      autoStart = true;
      # highPriority = true;
      defaultRuntime = true;
      config = {
        enable = true;
        json = {
          scale = 0.6;
          bitrate = 100000000;
          encoders = [
            {
              encoder = "nvenc";
              codec = "h264";
              width = 1.0;
              height = 1.0;
              offset_x = 0.0;
              offset_y = 0.0;
            }
          ];
        };
      };
      # package = inputs.lemonake.packages.${pkgs.system}.wivrn.override {
      # package = pkgs.wivrn.override {
      # cudaSupport = true;
      # ovrCompatSearchPaths = "${pkgs.xrizer}/lib/xrizer";
      # };
      # package = pkgs.wivrn.overrideAttrs (old: {
      #   cudaSupport = true;
      #   cmakeFlags =
      #     old.cmakeFlags
      #     ++ [
      #       (lib.cmakeBool "WIVRN_FEATURE_STEAMVR_LIGHTHOUSE" true)
      #     ];
      # });
      # monadoEnvironment = {
      #   WIVRN_USE_STEAMVR_LH = "1";
      #   LH_DISCOVER_WAIT_MS = "6000";
      # };
    };
  };

  environment.systemPackages = with pkgs; [
    sidequest
    # android-tools
    motoc
    # androidenv.androidPkgs.androidsdk # android stuff lol
    # androidenv.androidPkgs.platform-tools
  ];
  # programs.adb.enable = true;
  # users.users.nyx.extraGroups = ["adbusers"];
}
