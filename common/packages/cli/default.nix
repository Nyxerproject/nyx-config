{ pkgs, ... }:
{
  imports = [ ./nixvim ];
  environment.enableAllTerminfo = true;

  environment.systemPackages = with pkgs; [
    nix-your-shell
  ];

  home-manager.users.nyx = {
    home = {
      packages = with pkgs; [
        # monitoring
        btop # replacement of htop/nmon
        iotop # io monitoring
        bottom # cpu monitoring
        # mprocs # run multiple commands in parrallel
        htop # better top

        # system utilities
        zoxide # better cd
        # pik # process interactive kill # doesn't work on wsi???? idk
        dysk # find info about disk
        caligula # disk imageing

        ## compression
        xz # utility: compression
        ouch # utility: compression

        ## info grabbers
        onefetch # neofetch type beat
        bunbun

        ## Helpers
        navi # helper: cheat sheet for shell
        tealdeer # helper: gives tldrs for commands
        # halp # helper: cli tool to help with cli tools

        ## tui
        # gpg-tui # gpg tui thing.
        # youtube-tui # yt tui
        # tuisky # bluesky tui
        # bk # terminal epub reader
        # russ # RSS reader
        wiki-tui

        # nixos stuff
        # deploy-rs
        alejandra
        # nvd
        nix-output-monitor
        comma
        nix-health
        nix-init

        # shell utils
        # atuin # better history for shell

        # fuzzy finders
        skim # fzf but better
        fzf

        # text editors
        zed
        evil-helix
        # ox

        # development
        gitu # another terminal user inteface
        lazygit
        koji # dev: better git commiter
        git-cliff # dev: changlog maker
        cocogitto # conventional commits
        just
        # difftastic # dev: better diffs
        delta # dev: better diff highlighting
        typos
        # sad # dev: sed but better (idk what sed is lol)

        # networking thing
        trippy # utility: network scanner
        nmap # utility: A utility for network discovery and security auditing
        # sshs # ssh stuff
        atac # api sender thing

        ## download tools
        wget
        curl
        termscp # utility: download stuff easilly
        # monolith # download page as html

        fend # utility: calculator
        ripgrep-all # utility: ripgrep anything
        # parallel-disk-usage # utility: drive space
        tree # utility: recursive dir viewer
        tre-command # utility: tree alternative

        # development related
        ## productivity
        # taskwarrior-tui # TODO: list thing
        # taskwarrior3
        # taskchampion-sync-server
        # vault-tasks # todo

        # timewarrior # time thing
        # furtherance # time managment
        uair # pomodora

        # tui-journal # journal thing

        presenterm # present markdown files
        # clima # markdown view
        rucola
        # mask # start task from markdown file

        # goose-cli # llm cli thing
        # tenere # llm thing
        # aichat # llm stuff

        strace # system call monitoring
        # systeroid # alt to sysctl (w/ a tui :3)
        procs # alt to ps

        # system tools
        bluetui # settings: tui for bluetooth
        impala # settings: tui for wifi
        sysstat # monitoring: performance testing
        kmon # monitoring: kernel monitoring
        # wthrr # utility: cute weather thing
        # qrtool # utility: qrcode scanner and maker
        viu # png viewer in terminal
        # xplr # terminal file manager

        # media playback
        # ytermusic # media: download stuff in terminal
        # tabiew # view CSV and other documents in terminal

        cargo
        bacon
      ];
    };

    programs = {
      direnv.enable = true;
      nix-your-shell.enable = true;
      helix = {
        enable = true;
        package = pkgs.evil-helix;
        # languages = {
        #   language = [
        #     {
        #       name = "rust";
        #       # auto-format = false;
        #     }
        #   ];
        # };
      };
      nix-index = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
      };
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        options = [ "--cmd cd" ];
      };

      git = {
        enable = true;
        settings = {
          user = {
            name = "Nyxerproject";
            email = "nxyerproject@gmail.com";
          };
          core.editor = "nvim";
          push.default = "upstream";
          pull.rebase = true;
          rebase.autoStash = true;
          init.defaultBranch = "main";
          lfs.enable = true;
          # delta = {
          #   enable = true;
          #   options.features = "decorations side-by-side line-numbers";
          # };
          alias = {
            s = "status";
            p = "pull --rebase";
            f = "fetch";
          };
        };
        ignores = [
          "*~"
          ".direnv"
        ];
      };
      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batdiff
          prettybat
        ];
      };
      lsd.enable = true;
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
          "gs" = "git status";
          "tree" = "tre";
          "l" = "lsd -l";
          "ga" = "git add";
          "gc" = "git commit";
          "gcam" = "git commit -am";
          "gcm" = "git commit -m";
          "gco" = "git checkout";
          "gd" = "git diff";
          "gp" = "git push";
          "gdc" = "git diff --cached";
          "glg" = "git log --color --graph --pretty --oneline";
        };
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
          nix-your-shell fish | source
        '';
      };
      # bash.enable = true;
      # nushell.enable = true;
    };
  };
}
