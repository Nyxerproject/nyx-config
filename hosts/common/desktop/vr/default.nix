{
  pkgs,
  inputs,
  ...
}: let
  monado = pkgs.monado.overrideAttrs (previousAttrs: {
    src = previousAttrs.src.override {
      rev = "9baa28ee235ba0af9672650363de0eb86db6f646";
      sha256 = "sha256-9+iGEc40xNzmQrjr+80PHpAN9yrz3ohTtZpNu1y5dE8=";
    };
  });
  pkgsWivrn = import inputs.pkgs-wivrn {
    config.allowUnfree = true;
    hostPlatform.config = "x86_64-unknown-linux-gnu";
    system = "x86_64-linux"; # TODO there is prob a better way of declaring this
  };
in {
  imports = [./wivrn ./monado];

  environment.variables = {
    LH_DEFAULT_BRIGHTNESS = 1;
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
    LIBMONADO_PATH = "${pkgs.monado}/lib/libmonado.so";
    # U_PACING_APP_IMMEDIATE_WAIT_FRAME_RETURN = "1";
    # U_PACING_APP_USE_MIN_WAKE_PERIOD = "1";
    # U_PACING_COMP_MIN_TIME_MS = "4";
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
      package = pkgsWivrn.wivrn;
    };
  };

  environment.systemPackages = with pkgs; [
    sidequest
    android-tools
    motoc
    pkgsWivrn.wivrn
    opencomposite
    index_camera_passthrough
    monado
    libsurvive
    wlx-overlay-s
    xrgears
  ];
}
