{
  pkgs,
  lib,
  ...
}: {
  services.mullvad-vpn.package = lib.mkDefault pkgs.mullvad;
  services.mullvad-vpn.enable = true;
}
