{pkgs, ...}: {
  environment.systemPackages = let
    nyx-rebuild =
      pkgs.writers.writeBashBin "nyx-rebuild" {}
      /*
      bash
      */
      ''
        #!/usr/bin/env bash
        ask_question() {
            local question=$1
            while true; do
                read -p "$question [y/n]: " answer
                case $answer in
                    [Yy]* ) return 0;;
                    [Nn]* ) return 1;;
                    * ) echo "Please answer yes or no.";;
                esac
            done
        }

        pushd $FLAKE
        $EDITOR
        if git diff --quiet HEAD -- '*.nix'; then
          echo "No changes detected, exiting."
          popd
          exit 0
        fi

        # TODO: make this into a git hook instead
        alejandra . &>/dev/null \
          || ( alejandra . ; echo "formatting failed!" && exit 1)

        untracked_files=$(git ls-files -o --exclude-standard)
        if [[ -n "$untracked_files" ]]; then
            echo "Untracked files found:"
            echo "$untracked_files"
            echo "Please add or ignore these files before proceeding."
            notify-send -e "Please add or ignore files"
            popd
            exit 1
        fi

        git diff '*.nix'

        if ask_question "Would you like to commit new changes?"; then
            git add -u
            koji
        else
            echo "Skipping commit step."
        fi

        if ask_question "Switch?"; then
          if nh os switch ; then
            notify-send -e "NixOS Rebuilt OK!" --icon=software-update-urgent
          else
            notify-send -e "NixOS Build Failed!" --icon=dialog-warning
          fi
        else
            echo "ogi :3"
        fi
        popd
        exit 0
      '';
  in [nyx-rebuild];
}
