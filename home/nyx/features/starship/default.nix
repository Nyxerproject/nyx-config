{
  programs.starship = {
    enable = true;
    presets = [
      "nerd-font-symbols"
      #"Pastel Powerline"
    ]; # INFO: https://starship.rs/presets/
    settings = {
      add_newline = true;

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
