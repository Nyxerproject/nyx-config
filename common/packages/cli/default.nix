{pkgs, ...}: {
  imports = [./nixvim];
  environment = {
    systemPackages = with pkgs; [
      wget
      curl

      git

      koji # makes better commits

      htop # better top

      zoxide # better cd
      pik # process interactive kill # doesn't work on wsi???? idk
      lemmeknow # cli general helper

      onefetch # neofetch type beat

      youtube-tui # yt tui
      tuisky # bluesky tui

      presenterm # markdown presentations
      dysk # find info about disk

      atac # api sender thing

      gpg-tui # gpg tui thing.
      caligula # disk imageing

      inlyne # markdown file viewer
      clima # markdown view

      tenere # llm thing
      monolith # download page as html

      tui-journal # journal thing
      vault-tasks
      pipes-rs # pipe screen saver
      clock-rs # a clock

      porsmo # pomodora timer
      uair # pomodora

      bk # terminal epub reader
      russ # RSS reader

      # nixos stuff
      deploy-rs
      alejandra
      nvd
      nix-output-monitor
      comma
      nix-health
      nix-init
    ];
    enableAllTerminfo = true;
  };
  programs.direnv.enable = true;
  home-manager.users.nyx = {
    home = {
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

        # other text editors that I care less about but want to try
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
        # verco # dev: tui for multiple version control systems

        #trippy # utility: network scanner
        nmap # utility: A utility for network discovery and security auditing
        # netscanner # utility: network scanner
        # rustscan # utility: another network scanner
        # iftop # utility: network monitoring
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

        wthrr # utility: cute weather thing
        qrtool # utility: qrcode scanner and maker
        viu # png viewer in terminal
        xplr

        # media playback
        #termusic # media:  music in terminal
        ytermusic # media: download stuff in terminal

        tabiew # view CSV and other documents in terminal
        ttyper
      ];
      shellAliases = {
        cat = "bat -p";
        tree = "tre";
        l = "lsd -l";
        ga = "git add";
        gc = "git commit";
        gcam = "git commit -am";
        gcm = "git commit -m";
        gco = "git checkout";
        gcob = "git checkout -b";
        gcom = "git checkout master";
        gcod = "git checkout develop";
        gd = "git diff";
        gp = "git push";
        gdc = "git diff --cached";
        glg = "git log --color --graph --pretty --oneline";
        glgb = "git log --all --graph --decorate --oneline --simplify-by-decoration";
        gs = "git status";
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
      broot = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableNushellIntegration = true;
        settings.modal = true;
      };
      starship = {
        enable = true;
        enableFishIntegration = true;
      };
      fish = {
        enable = true;
        shellAbbrs = {
          "ga" = "git add";
          "gc" = "git commit";
          "gcam" = "git commit -am";
          "gcm" = "git commit -m";
          "gco" = "git checkout";
          "gcob" = "git checkout -b";
          "gcom" = "git checkout master";
          "gcod" = "git checkout develop";
          "gd" = "git diff";
          "gp" = "git push";
          "gdc" = "git diff --cached";
          "glg" = "git log --color --graph --pretty --oneline";
          "glgb" = "git log --all --graph --decorate --oneline --simplify-by-decoration";
          "gs" = "git status";
        };

        #nix-your-shell fish | source
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
      };
      #nushell.enable = true;
    };
  };
}
