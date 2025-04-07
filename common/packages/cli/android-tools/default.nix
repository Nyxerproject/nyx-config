{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    androidenv.androidPkgs.androidsdk # android stuff lol
    androidenv.androidPkgs.platform-tools
    android-tools
  ];
  programs.adb.enable = true;
  users.users.nyx.extraGroups = ["adbusers"];
}
