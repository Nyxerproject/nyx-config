{pkgs, ...}: {
  home.packages = with pkgs; [
    webcord-vencord # discord client w/ swag
    # webcord # discord client
    kotatogram-desktop # telegram client
    element-desktop # matrix client
  ];
}
