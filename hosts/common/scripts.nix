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
        $EDITOR ~/nyx-config/ # cd to your config dir
        if git diff --quiet HEAD -- '*.nix'; then
            echo "No changes detected, exiting."
            popd
            exit 0
        fi
        alejandra . &>/dev/null \
          || ( alejandra . ; echo "formatting failed!" && exit 1)
        git diff
        echo "NixOS Rebuilding..."
        # Rebuild, output simplified errors, log trackebacks
        nh os switch
        #>nixos-switch.log || (bat nixos-switch.log)
        # Get current generation metadata
        current=$(nixos-rebuild list-generations | grep current)
        # Commit all changes witih the generation metadata
        git commit -am "$current"
        popd
        notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
      '';
  in [nyx-rebuild];
}
