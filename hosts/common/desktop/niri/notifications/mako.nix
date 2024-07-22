{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # desktop notifications # TODO shouldn't be in home defaults
      mako
      # libnotify # is this needed?
    ];
  };
}
