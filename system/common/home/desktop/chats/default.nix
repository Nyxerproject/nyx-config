{pkgs, ...}: {
  imports = [./thunderbird];

  programs.nheko.enable = true;
  home.packages = with pkgs; [
    webcord-vencord # discord client
    dissent # discord client
    kotatogram-desktop # telegram client
    element-desktop-wayland # matrix client
  ]; # TODO: cleanup
}
