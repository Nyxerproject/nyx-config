{pkgs, ...}: let
  monado = pkgs.monado.overrideAttrs (previousAttrs: {
    src = previousAttrs.src.override {
      rev = "9baa28ee235ba0af9672650363de0eb86db6f646";
      sha256 = "sha256-9+iGEc40xNzmQrjr+80PHpAN9yrz3ohTtZpNu1y5dE8=";
    };
  });
in {
  environment.variables = {
    LH_DEFAULT_BRIGHTNESS = 1;
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
    LIBMONADO_PATH = "${pkgs.monado}/lib/libmonado.so";
    # U_PACING_APP_IMMEDIATE_WAIT_FRAME_RETURN = "1";
    # U_PACING_APP_USE_MIN_WAKE_PERIOD = "1";
    U_PACING_COMP_MIN_TIME_MS = "5";
  };

  programs.envision.enable = true;
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };

  environment.systemPackages = with pkgs; [
    index_camera_passthrough
    opencomposite
    monado
    wlx-overlay-s
    libsurvive
    xrgears
  ];
}
