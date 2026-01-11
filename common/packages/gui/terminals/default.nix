{
  lib,
  pkgs,
  ...
}:
{
  programs.bash.interactiveShellInit = ''
    if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
  '';

  home-manager.users.nyx.programs = {
    kitty.enable = true;
    rio = {
      enable = true;
      settings = {
        hide-cursor-when-typing = true;
        confirm-before-quit = false;
        fonts = lib.mkForce {
          family = "FiraCode Nerd Font";
          extra.family = "Noto Color Emoji";
        };
        shell.program = "fish";
        # developer = {
        #   log-level = "TRACE";
        #   enable-log-file = true;
        # };
        # renderer = {
        #   backend = "Vulkan";
        #   performance = "High";
        #   disable-occluded-render = false;
        #   disable-unfocused-render = false;
        # };
        # navigation = {
        #   mode = "Bookmark";
        #   clickable = true;
        #   open-config-with-split = true;
        #   use-split = true;
        # };
      };
    };
  };
}
