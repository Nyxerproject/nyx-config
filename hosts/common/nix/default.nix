{
  imports = [./hacks.nix];

  nixpkgs.config = {
    allowUnfree = true;
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];

    extra-substituters = ["https://yazi.cachix.org"];
    extra-trusted-public-keys = ["yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];
  };
}
