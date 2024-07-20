{
  inputs,
  pkgs,
  ...
}: {
  # imports = [
  # inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  # ];

  environment.variables = {
    LH_DEFAULT_BRIGHTNESS = 1;
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
    LIBMONADO_PATH = "${pkgs.monado}/lib/libmonado.so";
  };

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
