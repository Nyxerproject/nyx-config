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
      ];
    };
  };
}
