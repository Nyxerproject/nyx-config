{
  config,
  inputs,
  lib,
  pkgs,
  ...
  # }: let
}:
# inherit (lib.modules) mkIf;
# inherit (lib.options) mkEnableOption;
#cfg = config.profile.vr;
# amdgpu-kernel-module = pkgs.callPackage ./amdgpu.nix {
# kernel = config.boot.kernelPackages.kernel;
# };
# in {
{
  # options.profile.vr.enableHighPrioKernelPatch = mkEnableOption "kernel patch to allow high priority graphics for all clients";
  imports = [
    # ./envision.nix
  ];
  config = {
    # nixpkgs.xr.enableUnstripped = true;

    #boot.extraModulePackages = mkIf cfg.enableHighPrioKernelPatch [
    # (amdgpu-kernel-module.overrideAttrs (prev: {
    # patches = (prev.patches or []) ++ [inputs.scrumpkgs.kernelPatches.cap_sys_nice_begone.patch];
    # }))
    # ];

    systemd.user.services.monado.environment = {
      STEAMVR_LH_ENABLE = "1";
      XRT_COMPOSITOR_COMPUTE = "1";
      WMR_HANDTRACKING = "0";
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
    ];
  };
}
