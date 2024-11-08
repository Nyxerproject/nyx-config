{
  system,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.agenix.packages."${system}".default
  ];
  agenixSecrets = {files}: {
    age = {
      identityPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_rsa_key"
      ];

      secrets = files;
    };
  };
}
# TODO: add rules for sudo
# TODO: look into allowing passwordless sudo execution for wheel/sudo group
# TODO: add polkit authentication
# TODO: add agenix and/or sops-nix. agenix has the rekeying and idk if sops does
/*
helpful links:

sudo:
  https://wiki.archlinux.org/title/Sudo#Editing_files

polkit:
  # examples of someones polkit
  https://nixos.wiki/wiki/Polkit
  https://wiki.hyprland.org/Useful-Utilities/Must-have/
  https://www.reddit.com/r/NixOS/comments/171mexa/polkit_on_hyprland/
  https://github.com/erictossell/nixflakes/blob/9d377831c1357b1796b0ef19d04e7966245694ff/modules/hyprland/default.nix
  https://github.com/erictossell/nixflakes/blob/a9dd4ce7920654b6a409e6b446458e798361aa18/modules/core/security/polkit/default.nix
*/

