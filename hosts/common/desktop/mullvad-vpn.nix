{
  pkgs,
  lib,
  ...
}: {
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.mullvad-vpn.enable = true;
}
