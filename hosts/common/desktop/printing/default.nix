{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./prusaslicer.nix
    ./superslicer.nix
  ];
}
