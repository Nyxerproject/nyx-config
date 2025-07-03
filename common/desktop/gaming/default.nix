{pkgs, ...}: {
  home-manager.users.nyx.programs.mangohud.enable = true;
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      # dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-rtsp-bin
        proton-ge-bin
        (proton-ge-bin.overrideAttrs (finalAttrs: _: {
          version = "GE-Proton9-22-rtsp17-1";
          src = pkgs.fetchzip {
            url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
            hash = "sha256-GeExWNW0J3Nfq5rcBGiG2BNEmBg0s6bavF68QqJfuX8=";
          };
        }))
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    prismlauncher
  ];
}
