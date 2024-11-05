{
  nixpkgs.config = {
    permittedInsecurePackages = ["olm-3.2.16"];
  };
  config.nixpkgs.overlays = [
    (final: prev: {
      _7zz = prev._7zz.override {useUasm = true;};
    })
  ];
}
