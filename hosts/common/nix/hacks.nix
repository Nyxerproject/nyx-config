{pkgs, ...}: {
  programs.yazi.package = pkgs.yazi.override {
    _7zz = pkgs._7zz.override {useUasm = true;};
  };
  nixpkgs = {
    config = {
      permittedInsecurePackages = ["olm-3.2.16"];
    };
  };
}
