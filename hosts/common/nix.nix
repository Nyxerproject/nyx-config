{
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["olm-3.2.16"];
  };
  nix.settings.experimental-features = ["nix-command" "flakes"];
}
