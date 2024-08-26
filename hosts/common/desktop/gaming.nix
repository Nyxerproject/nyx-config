{
  lib,
  config,
  pkgs,
  ...
}: let
  steam = pkgs.steam.override {
    extraPkgs = pkgs:
      with pkgs; [
        gamescope
      ];
  };
in {
  environment.systemPackages = with pkgs; [
    r2modman
    steam-run
    protontricks
    lutris
    gamemode
    gamescope
  ];
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true; # Automatically invoke gamescope
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      (proton-ge-bin.overrideAttrs (finalAttrs: _: {
        version = "GE-Proton9-10-rtsp14";
        src = pkgs.fetchzip {
          url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
          hash = "sha256-jf1p33Kuqtriycf6gOw/IBdx/ts/P7PJd+pjxonAS/U=";
        };
      }))
      (proton-ge-bin.overrideAttrs (finalAttrs: _: {
        version = "GE-Proton9-4-rtsp7";
        src = pkgs.fetchzip {
          url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
          hash = "sha256-l/zt/Kv6g1ZrAzcxDNENByHfUp/fce3jOHVAORc5oy0=";
        };
      }))
    ];
  };
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "steam"
  #     "steam-original"
  #     "steam-runtime"
  #   ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "-f"
    ];
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        defaultgov = config.powerManagement.cpuFreqGovernor;
        desiredgov = "performance";
        # softrealtime = "on";
        # renice = 10;
        # ioprio = 1;
        inhibit_screensaver = 0;
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
        stop = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
      };
    };
  };
}
