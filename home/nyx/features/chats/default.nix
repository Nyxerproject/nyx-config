{pkgs, ...}: {
  imports = [
    ./iamb
  ];
  home = {
    # TODO: cleanup
    packages = with pkgs; [
      iamb # matrix tui client
    ];
  };
}
