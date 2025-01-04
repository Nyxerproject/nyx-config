{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.nur.modules.nixos.default
    inputs.nixos-generators.nixosModules.all-formats
    ./hacks.nix
    ./builders.nix
  ];
  environment.systemPackages = with pkgs; [deploy-rs];
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];

    # TODO: add more cachix suport and attic support
    extra-substituters = ["https://yazi.cachix.org"];
    extra-trusted-public-keys = ["yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];
  };
}
