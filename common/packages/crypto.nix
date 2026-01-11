{ pkgs, ... }:
{
  hardware.ledger.enable = true;
  environment.systemPackages = [
    pkgs.ledger-live-desktop
    # (pkgs.writeShellScriptBin "ledger-live-desktop" ''
    # unset NIXOS_OZONE_WL for this app only
    # exec env -u NIXOS_OZONE_WL ${pkgs.ledger-live-desktop}/bin/ledger-live-desktop "$@"
    # '')
  ];
}
