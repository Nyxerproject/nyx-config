{pkgs, ...}: {
  home = {
    stateVersion = "24.11";
    # TODO this is a mix of cli and gui stuff. it should be broken into parts
    # TODO cleanup
    packages = with pkgs; [
      thefuck

      # archives
      zip
      xz
      unzip
      crabz
      ouch

      # utils
      lsd # ls but better
      atuin # better history for shell

      skim # fzf but better
      fd
      bat

      sig

      # development
      gitui

      # networking tools
      trippy
      nmap # A utility for network discovery and security auditing
      netscanner
      iftop # network monitoring

      # drive space
      parallel-disk-usage

      # misc
      tree

      # nix related

      # productivity

      #hugo # static site generator
      #glow # markdown previewer in terminal

      btop # replacement of htop/nmon
      iotop # io monitoring
      # nvtopPackages.full # gpu monitoring # TODO do some work to make this install without unfree=true
      lact
      bottom # cpu monitoring
      navi # cheat sheet for shell
      tealdeer # gives tldrs for commands

      # system call monitoring
      strace # system call monitoring
      ltrace # library call monitoring
      systeroid # alt to sysctl (w/ a tui :3)
      procs # alt to ps

      # drive space
      parallel-disk-usage

      # system tools
      sysstat
      #lm_sensors # for `sensors` command
      ethtool
      #pciutils # lspci
      #usbutils # lsusb
      kmon # kernel monitoring

      keepassxc
      keepass-diff
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
      userEmail = "nxyerproject@gmail.com";
    };
  };
}
