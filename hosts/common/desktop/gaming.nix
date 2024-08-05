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
        urlVersion = "rtsp6-hotfix";
        version = "GE-Proton9-10-rtsp12-hotfix";
        src = pkgs.fetchzip {
          url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.urlVersion}/${finalAttrs.version}.tar.gz";
          hash = "sha256-o5YfTsmLzkCZWjn+J6v38AbuTXcKSAcVJdqt+Km4jwA=";
        };
      }))
      (proton-ge-bin.overrideAttrs (finalAttrs: _: {
        version = "GE-Proton9-10-rtsp12";
        src = pkgs.fetchzip {
          # url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
          url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/GE-Proton9-10-rtsp12/GE-Proton9-10-rtsp12.tar.gz";
          hash = "sha256-aHKOKhaOs1v+LwJdtQMDblcd5Oee9GzLC8SLYPA9jQQ=";
        };
      }))
      (proton-ge-bin.overrideAttrs (finalAttrs: _: {
        urlVersion = "GE-Proton9-9-rtsp11";
        version = "GE-Proton9-9-rtsp11";
        src = pkgs.fetchzip {
          url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.urlVersion}/${finalAttrs.version}.tar.gz";
          hash = "sha256-NMG/rJBeUTOawGUuMmBqanQuNjrjjpKg5oZkjE/ikJU=";
        };
      }))
      (proton-ge-bin.overrideAttrs (finalAttrs: _: {
        version = "GE-Proton9-5-rtsp8";
        src = pkgs.fetchzip {
          url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
          hash = "sha256-4q7pjxhNHnsOmlsWq3lMONRF2l3UK27GsNeMflVv1k0=";
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
