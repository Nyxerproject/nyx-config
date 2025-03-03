{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) optionals optionalAttrs;
  inherit (config.me) domain;
in {
  options = {me.domain = lib.mkOption {type = lib.types.str;};};

  config = lib.mkMerge [
    (optionalAttrs true {
      shb.user.acme = {
        uid = 995;
        gid = 994;
      };

      shb.certs.certs.letsencrypt.${domain} = {
        inherit domain;
        group = "nginx";
        reloadServices = ["nginx.service"];
        adminEmail = "ibizaman@${domain}";
        afterAndWants = optionals config.services.dnsmasq.enable ["dnsmasq.service"];
      };
    })
  ];
}
