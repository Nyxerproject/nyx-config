{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixpkgs-xr.nixosModules.nixpkgs-xr
  ];

  config = {
    nixpkgs.xr.enableUnstripped = true;

    # environment.variables = {
    systemd.user.services.monado.environment = {
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
      WMR_HANDTRACKING = "0";
      # XRT_HAVE_STEAM = "YES";
    };

    services.monado = {
      enable = true;
      defaultRuntime = true;
    };

    environment.systemPackages = with pkgs; [
      index_camera_passthrough
      opencomposite-helper
      opencomposite
      wlx-overlay-s
      libsurvive
      xrgears
    ];
  };
}
