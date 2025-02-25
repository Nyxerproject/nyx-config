{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [lan-mouse];
  };
  #programs.lan-mouse = {
  #  enable = true;
  #};
}
