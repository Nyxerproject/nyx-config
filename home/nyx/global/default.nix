{pkgs, ...}: {
  imports = [
    ../features
  ];

  home = {
    stateVersion = "24.11";
    # TODO this is a mix of cli and gui stuff. it should be broken into parts
    # TODO cleanup
    packages = with pkgs; [
      # helpers
      thefuck # terminal helper
      navi # cheat sheet for shell
      tealdeer # gives tldrs for commands
      halp # cli tool to help with cli tools

      # archives
      zip
      xz
      unzip
      crabz
      ouch

      # utils
      atuin # better history for shell
      ## replacments
      lsd # ls but better
      bat
      skim # fzf but better
      sig
      fd

      # development
      git
      gitui
      git-cliff
      delta # better highlighting
      koji # better git commiter
      cocogitto # conventional commits
      difftastic

      # networking tools
      trippy # network scanner
      nmap # A utility for network discovery and security auditing
      netscanner # network scanner
      iftop # network monitoring
      termscp # download stuff easilly
      bluetui # tui for bluetooth
      impala # tui for wifi

      fend # calculator
      ripgrep-all # ripgrep anything

      # drive space
      parallel-disk-usage

      # misc
      tree

      # nix related
      # productivity
      taskwarrior-tui # todo list thing
      mask
      #rucola # in a pr
      comrak
      mdbook
      presenterm

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
      sysstat
      #lm_sensors # for `sensors` command
      ethtool
      #pciutils # lspci
      #usbutils # lsusb
      kmon # kernel monitoring

      # drive space
      parallel-disk-usage

      keepassxc

      termusic
      ytermusic
    ];
  };

  programs = {
    bash.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    }; # TODO alias this to cd

    git = {
      enable = true;
      userName = "Nyxerproject";
      userEmail = "nyxerproject@gmail.com";
      lfs.enable = true;
      delta = {
        enable = true;
        options.features = "decorations side-by-side line-numbers";
      };
      ignores = [
        "*~"
        ".direnv"
      ];
      # extraConfig = {
      #   gitlab.user = userinfo.gitlabUser;
      #   core.editor = "nvim";
      #   push.default = "upstream";
      #   pull.rebase = true;
      #   rebase.autoStash = true;
      #   init.defaultBranch = "main";
      #   color = {
      #     ui = "auto";
      #     branch = "auto";
      #     status = "auto";
      #     diff = "auto";
      #     interactive = "auto";
      #     grep = "auto";
      #     decorate = "auto";
      #     showbranch = "auto";
      #     pager = true;
      #   };
      # };
    }; # look here https://github.com/johnae/world/blob/main/users/profiles/git.nix
    gitui.enable = true;
    bat.enable = true;
  };
}
