{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./zellij
    ./starship
    ./chats
    ./fish
  ];
  home = {
    stateVersion = "24.11";
    packages = with pkgs; [
      thefuck # helper: terminal helper
      navi # helper: cheat sheet for shell
      tealdeer # helper: gives tldrs for commands
      halp # helper: cli tool to help with cli tools

      xz # utility: compression
      ouch # utility: compression

      atuin # better history for shell
      skim # fzf but better
      fzf
      funzzy # file watcher
      #sig # ??? # TODO: figure out these
      #fd # ????

      # other text editors that I care less about but want to try
      zed
      lapce
      helix
      ox
      # development
      git # dev: version control
      gitui # dev: tui for git
      gitu # another terminal user inteface
      git-cliff # dev: changlog maker
      lazygit
      koji # dev: better git commiter
      sad # dev: sed but better (idk what sed is lol)
      cocogitto # conventional commits
      serie # better git commit charts
      difftastic # dev: better diffs
      delta # dev: better diff highlighting
      gdbgui
      typos
      # irrelevent: optimistic merging http://hintjens.com/blog:106
      #verco # dev: tui for multiple version control systems

      #trippy # utility: network scanner
      nmap # utility: A utility for network discovery and security auditing
      #netscanner # utility: network scanner
      #rustscan # utility: another network scanner
      #iftop # utility: network monitoring
      sshs # ssh stuff
      tuisky
      wiki-tui
      meli

      termscp # utility: download stuff easilly
      bluetui # settings: tui for bluetooth
      impala # settings: tui for wifi
      #fend # utility: calculator
      ripgrep-all # utility: ripgrep anything
      parallel-disk-usage # utility: drive space
      tree # utility: recursive dir viewer
      tre-command # utility: tree alternative

      # development related
      ## productivity
      taskwarrior-tui # TODO: list thing
      taskwarrior3
      # vault-tasks # tui markdown task manager WARN: not in nixpkgs yet
      taskchampion-sync-server
      timewarrior # time thing
      furtherance # time managment
      mask # start task from markdown file
      rucola
      comrak
      mdbook # make a book
      presenterm # present markdown files

      # Monitoring
      btop # replacement of htop/nmon
      iotop # io monitoring
      bottom # cpu monitoring
      mprocs # run multiple commands in parrallel

      lact # gpu configuration

      strace # system call monitoring
      ltrace # library call monitoring
      systeroid # alt to sysctl (w/ a tui :3)
      procs # alt to ps

      # system tools
      sysstat # monitoring: performance testing
      kmon # monitoring: kernel monitoring

      # drive space
      parallel-disk-usage

      keepassxc # security: password manager
      waveterm # TODO: move waveterm elseware
      spacedrive

      wthrr # utility: cute weather thing
      qrtool # utility: qrcode scanner and maker
      viu # png viewer in terminal
      xplr

      # media playback
      termusic # media:  music in terminal
      ytermusic # media: download stuff in terminal

      tabiew # view CSV and other documents in terminal
      ttyper
    ];
    shellAliases = {
      cat = "bat -p";
      tree = "tre";
      l = "lsd -l";
    };
    stylix = {
      targets = {
        steam = {
          enable = true;
          adwaitaForSteam.enable = true;
        };
      };
    };
  };

  programs = {
    nix-index = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    bash.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    }; # TODO: alias this to cd

    git = {
      enable = true;
      userName = "Nyxerproject";
      userEmail = "nyxerproject@gmail.com";
      lfs.enable = true;
      delta = {
        enable = true;
        options.features = "decorations side-by-side line-numbers";
      };
      ignores = ["*~" ".direnv"];
      aliases = {
        s = "status";
        p = "pull --rebase";
        f = "fetch";
      };
      extraConfig = {
        core.editor = "nvim";
        push.default = "upstream";
        pull.rebase = true;
        rebase.autoStash = true;
        init.defaultBranch = "main";
      };
    };
    gitui.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        prettybat
      ];
    };
    lsd = {
      enable = true;
      enableAliases = true;
    };
    nh = {
      flake = "/home/nyx/nyx-config";
      enable = true;
      clean.enable = true;
      clean = {
        dates = "monthly";
        extraArgs = "--keep 5 --keep-since 7d";
      };
    };
    yazi.enable = true;
    #nushell.enable = true;
  };
}
