{pkgs, ...}: {
  networking.hostName = "antidown";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt # for newer GPUs on NixOS >24.05 or unstable
    ];
  };

  services.xserver.enable = true;

  system.stateVersion = "24.05";
}
