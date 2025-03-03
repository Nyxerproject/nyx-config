{
  lib,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [deploy-rs];
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
    overlays = [
      inputs.sddm-sugar-candy-nix.overlays.default
      inputs.niri.overlays.niri
    ];
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "@wheel"];
    extra-substituters = ["https://yazi.cachix.org"];
    extra-trusted-public-keys = ["yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];
  };
}
