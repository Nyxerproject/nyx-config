{pkgs, ...}: {
  environment.systemPackages = let
    nyx-rebuild =
      pkgs.writers.writeBashBin "nyx-rebuild" {}
      /*
      bash
      */
      ''
        #!/usr/bin/env bash
        set -e # Edit your config
        pushd ~/nyx-config/
        $EDITOR
        if git diff --quiet HEAD -- '*.nix'; then
          echo "No changes detected, exiting."
          popd
          exit 0
        fi
        alejandra . &>/dev/null \
          || ( alejandra . ; echo "formatting failed!" && exit 1)
        git diff -U0 '*.nix'
        echo "NixOS Rebuilding..."

        if nh os build ; then
          if nh os switch >/dev/null ; then
            current=$(nixos-rebuild list-generations | grep current)
            git commit -am "$current"
            popd
            notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
          else
            notify-send -e "NixOS Switch Failed!" --icon=software-update-available
          fi
        else
          notify-send -e "NixOS Build Failed!" --icon=software-update-available
        fi
        popd
        exit 0
      '';
  in [nyx-rebuild];
}
