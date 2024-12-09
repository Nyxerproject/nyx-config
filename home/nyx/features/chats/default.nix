{pkgs, ...}: {
  imports = [
    ./iamb
  ];
  home = {
    # TODO: cleanup
    packages = with pkgs; [
      tgt # telegram tui
      iamb # matrix tui client
    ];
  };
}
