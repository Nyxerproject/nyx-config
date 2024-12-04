{pkgs, ...}: {
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
