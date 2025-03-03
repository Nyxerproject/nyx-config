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
      shb.user.jellyfin = {
        uid = 984;
        gid = 981;
        extraGroups = ["media"];
      };

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["jellyfin.${domain}"];
      shb.jellyfin = {
        enable = true;
        inherit domain;
        subdomain = "jellyfin";
        ssl = config.shb.certs.certs.letsencrypt.${domain};
        ldap = {
          enable = true;
          host = "127.0.0.1";
          port = config.shb.ldap.ldapPort;
          dcdomain = config.shb.ldap.dcdomain;
          adminPassword.result = config.shb.sops.secret."jellyfin/ldap_password".result;
          userGroup = "jellyfin_user";
        };
        sso = {
          enable = true;
          endpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
          clientID = "jellyfin";
          sharedSecret.result = config.shb.sops.secret."jellyfin/sso_secret".result;
          sharedSecretForAuthelia.result = config.shb.sops.secret."jellyfin/authelia/sso_secret".result;
          userGroup = "jellyfin_user";
          adminUserGroup = "jellyfin_admin";
        };
      };
      shb.sops.secret."jellyfin/ldap_password" = {
        request = config.shb.jellyfin.ldap.adminPassword.request;
        settings.key = "ldap/user_password";
      };
      shb.sops.secret."jellyfin/sso_secret" = {
        request = config.shb.jellyfin.sso.sharedSecret.request;
      };
      shb.sops.secret."jellyfin/authelia/sso_secret" = {
        request = config.shb.jellyfin.sso.sharedSecretForAuthelia.request;
        settings.key = "jellyfin/sso_secret";
      };

      shb.zfs.datasets."safe/jellyfin".path = "/var/lib/jellyfin";
    })
  ];
}
