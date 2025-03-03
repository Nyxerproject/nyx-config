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
      shb.user.lldap = {
        uid = 991;
        gid = 989;
      };

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["ldap.${domain}"];
      shb.ldap = {
        enable = true;
        inherit domain;
        subdomain = "ldap";
        ssl = config.shb.certs.certs.letsencrypt.${domain};
        ldapPort = 3890;
        webUIListenPort = 17170;
        dcdomain = "dc=mydomain,dc=com";
        ldapUserPassword.result = config.shb.sops.secret."ldap/user_password".result;
        jwtSecret.result = config.shb.sops.secret."ldap/jwt_secret".result;
        # restrictAccessIPRange = "192.168.50.0/24";
        debug = false;
      };
      shb.sops.secret."ldap/user_password".request = config.shb.ldap.ldapUserPassword.request;
      shb.sops.secret."ldap/jwt_secret".request = config.shb.ldap.jwtSecret.request;

      shb.zfs.datasets."safe/ldap2".path = "/var/lib/private/lldap";
    })
  ];
}
