{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    direnv
    koji # makes better commits
    htop # better top
    zoxide # better cd
    pik # process interactive kill # doesn't work on wsi???? idk

    bk # terminal epub reader
    youtube-tui # yt tui
    tuisky # bluesky tui
    monolith # download page as html
    lemmeknow # cli general helper
    onefetch # neofetch type beat
    silicon # pretty sourcecode maker
    presenterm # markdown presentations
    clima # markdown view
    dysk # find info about disk

    # nixos stuff
    alejandra
    nvd
    nix-output-monitor
    comma
    nix-health
    nix-init
    inputs.vault-tasks.packages.${pkgs.system}.default
    # TODO: move all of this to nix.nix
  ];
  programs.yazi = {
    enable = true;
  };
}