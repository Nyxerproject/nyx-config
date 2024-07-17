{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    lunarvim
    wget
    curl
    git
    htop

    # nixos stuff
    alejandra
    nh
    nvd
    nix-output-monitor
    comma
    nix-health
  ];
}
