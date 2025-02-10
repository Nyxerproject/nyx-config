{
  pkgs,
  inputs,
  ...
}: {
  environment = {
    systemPackages = with pkgs; [
      wget
      curl
      git
      direnv
      koji # makes better commits
      htop # better top
      zoxide # better cd
      pik # process interactive kill # doesn't work on wsi???? idk

      # TODO: move all of this
      bk # terminal epub reader
      #youtube-tui # yt tui
      #tuisky # bluesky tui
      monolith # download page as html
      lemmeknow # cli general helper
      onefetch # neofetch type beat
      #silicon # pretty sourcecode maker
      presenterm # markdown presentations
      clima # markdown view
      #dysk # find info about disk
      atac # api sender thing
      gpg-tui
      #caligula # disk imageing
      tenere # llm thing
      tui-journal
      inlyne # markdown file viewer
      tectonic # latex compiler

      russ # RSS reader

      # nixos stuff
      alejandra
      nvd
      nix-output-monitor
      comma
      nix-health
      nix-init
      # inputs.vault-tasks.packages.${pkgs.system}.default
      # TODO: move all of this to nix.nix
    ];
    enableAllTerminfo = true;
  };
  programs.yazi = {
    enable = true;
  };
}
