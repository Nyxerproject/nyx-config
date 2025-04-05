{pkgs, ...}: {
  environment.variables = {
    WIVRN_USE_STEAMVR_LH = 1;
    LH_DISCOVER_WAIT_MS = 6000;
  };

  services = {
    wivrn = {
      enable = true;
      openFirewall = true;
      autoStart = true;
      defaultRuntime = true;
    };
  };

  environment.systemPackages = with pkgs; [
    sidequest
    android-tools
    motoc
    # androidenv.androidPkgs.androidsdk # android stuff lol
    # androidenv.androidPkgs.platform-tools
  ];
  programs.adb.enable = true;
  users.users.nyx.extraGroups = ["adbusers"];

  home-manager.users.nyx.xdg.configFile."openxr/1/active_runtime.json".source = "${pkgs.wivrn}/share/openxr/1/openxr_wivrn.json";
}
