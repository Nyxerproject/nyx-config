{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    htop
    zoxide
    #pik # process interactive kill # doesn't work on wsi???? idk

    # nixos stuff
    alejandra
    nh
    nvd
    nix-output-monitor
    comma
    nix-health
  ];
  programs.yazi = {
    enable = true;
  };
}
