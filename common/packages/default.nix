{pkgs, ...}: {
  imports = [./scripts.nix ./cli];
  environment.systemPackages = with pkgs; [
    (mistral-rs.overrideAttrs (finalAttrs: previousAttrs: {
      # version = "unstable-2025-05-16";
      src = pkgs.fetchFromGitHub {
        owner = "EricLBuehler";
        repo = "mistral.rs";
        rev = "380da230bd7cff64e5d22b2876f5841b662fba3b";
        hash = "sha256-fwpVmdaPOeHx+Jmz8CZGkRuWozflAjxLQibOd1JqTAE=";
      };
      cargoDeps = pkgs.rustPlatform.importCargoLock {
        lockFile = finalAttrs.src + "/Cargo.lock";
        allowBuiltinFetchGit = true;
      };
      cargoHash = null;
    }))
    (ollama.overrideAttrs (finalAttrs: previousAttrs: {
      version = "0.7.0";
      src = pkgs.fetchFromGitHub {
        owner = "ollama";
        repo = "ollama";
        tag = "v${finalAttrs.version}";
        hash = "sha256-rkSWMGMKzs7V6jmxS3fG611Zahsyzz5kDI8L4HxQSfQ=";
        fetchSubmodules = true;
      };
    }))
  ];
}
