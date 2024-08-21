{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./prusaslicer.nix
    ./superslicer.nix
  ];
}
