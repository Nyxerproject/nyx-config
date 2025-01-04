{pkgs, ...}: {
  programs.fish = {
    enable = true;
    shellAbbrs = {
      "ga" = "git add";
      "gc" = "git commit";
      "gcam" = "git commit -am";
      "gcm" = "git commit -m";
      "gco" = "git checkout";
      "gcob" = "git checkout -b";
      "gcom" = "git checkout master";
      "gcod" = "git checkout develop";
      "gd" = "git diff";
      "gp" = "git push";
      "gdc" = "git diff --cached";
      "glg" = "git log --color --graph --pretty --oneline";
      "glgb" = "git log --all --graph --decorate --oneline --simplify-by-decoration";
      "gs" = "git status";
    };

    #nix-your-shell fish | source
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };
}
