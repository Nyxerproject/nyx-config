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
        git diff '*.nix'
        echo "NixOS Rebuilding..."

        if nh os build ; then
          koji
          notify-send -e "NixOS Rebuilt OK!" --icon=dialog-password
          if nh os switch >/dev/null ; then
            notify-send -e "NixOS Rebuilt OK!" --icon=software-update-urgent
            popd
            exit 0
          fi
        else
        notify-send -e "NixOS Build Failed!" --icon=dialog-warning
        fi
        popd
        exit 0
      '';
  in [nyx-rebuild];
}
