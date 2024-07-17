{ pkgs, ... } : 
{
  environment.systemPackages = with pkgs; [
    zoxide
  ];
  imports = [
    ./scripts.nix
  ];
}
