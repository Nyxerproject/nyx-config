{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs = {
    overlays = [
      inputs.jeezyvim.overlays.default
    ];
  };
  environment.systemPackages = with pkgs; [
    jeezyvim
  ];
}
