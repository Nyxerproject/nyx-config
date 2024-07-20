{
  pkgs,
  lib,
  ...
}: {
  # services.mullvad-vpn.package = pkgs.mullvad-vpn;
  # TODO borked due to wayland and polkit. just use the cli
  services.mullvad-vpn.package = pkgs.mullvad;
  services.mullvad-vpn.enable = true;
}
