{pkgs, ...}: {
  environment.systemPackages = let
    nyx-rebuild =
      pkgs.writers.writeBashBin "nr" {}
      /*
      bash
      */
      ''
        $EDITOR $NH_FLAKE

        # TODO: make this into a git hook instead
        alejandra $NH_FLAKE &>/dev/null \
          || ( alejandra $NH_FLAKE ; echo "formatting failed!" && exit 1)

        untracked_files=$(git -C $NH_FLAKE ls-files -o --exclude-standard)
        if [[ -n "$untracked_files" ]]; then
            echo "Untracked files found:"
            echo "$untracked_files"
            echo "Please add or ignore these files before proceeding."
            exit 1
        fi

        if git diff --quiet HEAD -- '*.nix'; then
          echo "No changes detected, exiting."
          exit 0
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
        exit 0
      '';
  in [nyx-rebuild];
}
