{pkgs, ...}: {
  networking.hostName = "antidown";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [vpl-gpu-rt];
  };

  services.xserver.enable = true;
}
