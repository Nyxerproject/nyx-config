{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      # dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        (proton-ge-bin.overrideAttrs (finalAttrs: _: {
          version = "GE-Proton9-20-rtsp16";
          src = pkgs.fetchzip {
            url = "https://github.com/SpookySkeletons/proton-ge-rtsp/releases/download/${finalAttrs.version}/${finalAttrs.version}.tar.gz";
            hash = "sha256-iq7oiDW5+51wzqYwASOGSV922c/pg1k29MdkIXlT34k=";
          };
        }))
      ];
    };
  };
}
