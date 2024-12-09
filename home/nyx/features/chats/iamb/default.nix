{
  imports = [./iamb_mod.nix];

  programs.iamb = {
    enable = true;
    settings = {
      profiles.main = {
        user_id = "@nyxerproject:matrix.org";
        settings = {
          image_preview = {
            protocol.type = "sixel";
            size = {
              height = 10;
              width = 30;
            };
          };
          users = {
            "@nyxerproject:matrix.org" = {
              name = "nyx";
              color = "yellow";
            };
          };
          message_user_color = false;
          notifications.enabled = true;
          open_command = ["xdg-open"];
          user_gutter_width = 20;
          username_display = "displayname";
        }; # NOTE: <S-Tab> does not work
        macros = {
          # "normal|visual" = {
          #   "Q" = ":qa<CR>";
          #   "s" = "<C-W>m";
          #   "<C-o>" = ":open<CR>";
          #   "r" = ":react ";
          #   "e" = ":edit<CR>";
          #   "E" = ":reply<CR>";
          #   "<Esc>" = ":cancel<CR>y";
          #   "z" = "<C-W>z";
          #   "t" = ":redact<CR>";
          #   "<C-N>" = ":tabn<CR>";
          #   "<C-P>" = ":tabp<CR>";
          # };
        };
        layout = {
          style = "config";
          tabs = [
            # {window = "@johnpier:matrix.org";}
            # {window = "#lobster-general:matrix.org";}
            # {window = "#gen-ani-cli:matrix.org";}
            # {window = "!wrozWEyuWGynHqPCZf:mrfluffy.xyz";}
            # examples ^
          ];
        };
      };
    };
  };
  # lifted from here: https://github.com/justchokingaround/nude/blob/f02530b3cf6796bbf9cc28d0271fbcc1093f1732/home-manager/iamb.nix#L4
  # thanks justchokingaround <3
}
