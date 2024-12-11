{config, ...}: {
  imports = [./swaync_mod.nix];
  services.swaync = {
    enable = true;
    settings = {
      image-visibility = "when-available";
      hide-on-clear = true;
      positionY = "top";
      layer-shell = true;
    };
  };
  programs.swaync.enable = true;
}
