{pkgs, ...}: {
  imports = [
    ./iamb
  ];
  programs.nheko.enable = true;
  home = {
    # TODO: cleanup
    packages = with pkgs; [
      # Instant messaging packages
      webcord-vencord # discord client
      dissent # discord client
      kotatogram-desktop # telegram client
      tgt # telegram tui
      element-desktop-wayland # matrix client
      iamb # matrix tui client
    ];
  };
}
