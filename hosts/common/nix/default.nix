{
  imports = [/hacks.nix];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = ["olm-3.2.16"];
  };
  config.nixpkgs.overlays = [
    (final: prev: {
      _7zz = prev._7zz.override {useUasm = true;};
    })
  ];
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    extra-substituters = ["https://yazi.cachix.org"];
    extra-trusted-public-keys = ["yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];
  };
}
