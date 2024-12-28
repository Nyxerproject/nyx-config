{pkgs, ...}: {
  imports = [./thunderbird];

  programs.nheko.enable = true;
  home.packages = with pkgs; [
    #webcord-vencord # discord client
    webcord # discord client
    dissent # discord client
    kotatogram-desktop # telegram client
    element-desktop # matrix client
  ]; # TODO: cleanup
}
