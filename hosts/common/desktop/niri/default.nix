{pkgs, ...}: {
  import = [
    ./notifications/
    ./fuzzel.nix
  ]
  environment = {
    systemPackages = with pkgs; [
      # add other things for niri
      niri
      alacritty # just to make sure it is available
      fuzzel
    ];
  };
  programs.niri.enable = true;
}
