{pkgs, ...}: let
in {
  imports = [
    ./scripts.nix
    ./cli
    # ./mistralrs.nix
  ];
  environment.systemPackages = with pkgs; [
    (mistral-rs.overrideAttrs (finalAttrs: previousAttrs: {
      # version = "unstable-2025-05-16";
      src = pkgs.fetchFromGitHub {
        owner = "EricLBuehler";
        repo = "mistral.rs";
        rev = "380da230bd7cff64e5d22b2876f5841b662fba3b";
        hash = "sha256-fwpVmdaPOeHx+Jmz8CZGkRuWozflAjxLQibOd1JqTAE=";
      };
      # Doesn't require IFD
      # cargoDeps = previousAttrs.cargoDeps.overrideAttrs {
      #   name = "nil-vendor.tar.gz";
      #   inherit (finalAttrs) src;
      #   outputHash = pkgs.lib.fakeHash;
      # };
      # Requires IFD
      cargoDeps = pkgs.rustPlatform.importCargoLock {
        lockFile = finalAttrs.src + "/Cargo.lock";
        allowBuiltinFetchGit = true;
      };
      cargoHash = null;
    }))
  ];
  # GUI stuff is imported via '/common/desktop/default.nix'
}
