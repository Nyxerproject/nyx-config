{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # desktop notifications # TODO shouldn't be in home defaults
      mako
      libnotify
    ];
  };
}
# {pkgs, ...}: {
#   services.mako = {
#     enable = true;
#     #font = "Roboto";
#     backgroundColor = "#000021DD";
#     textColor = "#FFFFFFFF";
#     borderSize = 0;
#     borderRadius = 15;
#     icons = true;
#     iconPath = "${pkgs.moka-icon-theme}/share/icons/Moka";
#     markup = true;
#     actions = true;
#     defaultTimeout = 3000;
#     padding = "20";
#     height = 200;
#     width = 500;
#     layer = "overlay";
#   };
#   environment.systemPackages = with pkgs; [
#     libnotify
#   ];
# }

