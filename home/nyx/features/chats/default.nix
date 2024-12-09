{pkgs, ...}: {
  imports = [
    ./iamb
  ];
  programs.nheko.enable = true;
  home = {
    # TODO: cleanup
    packages = with pkgs; [
      tgt # telegram tui
      iamb # matrix tui client
    ];
  };
}
