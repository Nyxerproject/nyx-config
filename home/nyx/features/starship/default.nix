{
  config,
  lib,
  ...
}: let
  cfg = config.cli.programs.starship;
  inherit (config.lib.stylix) colors;
in {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      palette = "custom";
      palettes.custom = {
        rosewater = "#${colors.base06}";
        flamingo = "#${colors.base0F}";
        pink = "#f6c2e7";
        mauve = "#${colors.base0E}";
        red = "#${colors.base08}";
        maroon = "#eba0ac";
        peach = "#${colors.base09}";
        yellow = "#${colors.base0A}";
        green = "#${colors.base0B}";
        teal = "#${colors.base0C}";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#${colors.base0D}";
        lavender = "#${colors.base07}";
        text = "#${colors.base05}";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#${colors.base04}";
        surface1 = "#${colors.base03}";
        surface0 = "#${colors.base02}";
        base = "#${colors.base00}";
        mantle = "#${colors.base01}";
        crust = "#11111b";
      };

      lua = {
        symbol = "[](blue) ";
      };

      c = {
        symbol = " ";
      };

      directory = {
        read_only = "RO";
      };

      git_branch = {
        symbol = " ";
      };

      nix_shell = {
        symbol = " ";
      };

      golang = {
        symbol = " ";
      };

      python = {
        symbol = " ";
      };

      rust = {
        symbol = " ";
      };

      #nix_shell.disabled = false;

      directory = {
        #truncation_length = 8;
        #truncation_symbol = ".../";
        #read_only = " RO";
      };

      # INFO: git_status is slow for large repos
      git_status.disabled = false;

      # hostname = {
      #   format = "@[$hostname]($style):";
      #   ssh_only = false;
      # };

      # status = {
      #   disabled = false;
      #   symbol = "E";
      # };

      # time = {
      #   disabled = false;
      #   format = "[$time]($style) ";
      # };

      # username = {
      #   format = "[$user]($style)";
      #   show_always = true;
      # };
    };
  };
}
