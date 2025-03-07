{
  networking.hostName = "tau";
  hardware.enableRedistributableFirmware = true;
  boot = {
    # # make the camera available as v4l device
    # kernelModules = ["bcm2835-v4l2"];
    # extraModprobeConfig = ''
    #   options uvcvideo nodrop=1 timeout=6000
    # '';
    loader = {
      raspberryPi = {
        enable = true;
        version = 3;
        uboot.enable = true;
      };
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  # services.mjpg-streamer = {
  #   enable = true;
  #   inputPlugin = "input_uvc.so";
  # };
  /*
     plugins = let
    # https://plugins.octoprint.org/plugins/ender3v2tempfix/
    # TODO: add to nixpkgs
    ender3v2tempfix = pkgs.python3Packages.buildPythonPackage {
      pname = "OctoPrintPlugin-ender3v2tempfix";
      propagatedBuildInputs = [pkgs.octoprint];
      doCheck = false;
      version = "unstable-2019-04-27";
      src = pkgs.fetchFromGitHub {
        owner = "SimplyPrint";
        repo = "OctoPrint-Creality2xTemperatureReportingFix";
        rev = "2c4183b6a0242a24ebf646d7ac717cd7a2db2bcf";
        sha256 = "03bc2zbffw4ksk8if90kxhs3179nbhb4xikp4f0adm3lrnvxkd3s";
      };
    };
  in
    plugins:
      with plugins; [
        ender3v2tempfix
        themeify
        stlviewer
        abl-expert
        bedlevelvisualizer
        costestimation
        gcodeeditor
        telegram
        touchui
        #octoklipper
        octoprint-dashboard
      ];
  };
  */
  /*
     nixpkgs.overlays = [
    (self: super: {
      # https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_3
      # "In case wlan0 is missing, try overlaying an older firmwareLinuxNonfree confirmed to be working"
      firmwareLinuxNonfree = super.firmwareLinuxNonfree.overrideAttrs (old: {
        version = "2020-12-18";
        src = pkgs.fetchgit {
          url = "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git";
          rev = "b79d2396bc630bfd9b4058459d3e82d7c3428599";
          sha256 = "1rb5b3fzxk5bi6kfqp76q1qszivi0v1kdz1cwj2llp5sd9ns03b5";
        };
        outputHash = "1p7vn2hfwca6w69jhw5zq70w44ji8mdnibm1z959aalax6ndy146";
      });
    })
  ];
  */
  system.stateVersion = "25.05";
}
