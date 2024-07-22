{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    lunarvim
    wget
    curl
    git
    htop
    zoxide

    # nixos stuff
    alejandra
    nh
    nvd
    nix-output-monitor
    comma
    nix-health
  ];
}
