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
      shb = {
        user.authelia = {
          uid = 993;
          gid = 992;
        };

        certs.certs.letsencrypt.${domain}.extraDomains = ["authelia.${domain}"];
        authelia = {
          enable = true;
          inherit domain;
          subdomain = "authelia";
          ssl = config.shb.certs.certs.letsencrypt.${domain};

          ldapHostname = "127.0.0.1";
          ldapPort = config.shb.ldap.ldapPort;
          dcdomain = config.shb.ldap.dcdomain;

          smtp = {
            host = "smtp.eu.mailgun.org";
            port = 587;
            username = "postmaster@mg.${domain}";
            from_address = "authelia@${domain}";
            password.result = config.shb.sops.secret."authelia/smtp_password".result;
          };

          secrets = {
            jwtSecret.result = config.shb.sops.secret."authelia/jwt_secret".result;
            ldapAdminPassword.result = config.shb.sops.secret."authelia/ldap_admin_password".result;
            sessionSecret.result = config.shb.sops.secret."authelia/session_secret".result;
            storageEncryptionKey.result = config.shb.sops.secret."authelia/storage_encryption_key".result;
            identityProvidersOIDCHMACSecret.result = config.shb.sops.secret."authelia/hmac_secret".result;
            identityProvidersOIDCIssuerPrivateKey.result = config.shb.sops.secret."authelia/private_key".result;
          };
        };
        sops.secret = {
          "authelia/jwt_secret".request = config.shb.authelia.secrets.jwtSecret.request;
          "authelia/ldap_admin_password".request = config.shb.authelia.secrets.ldapAdminPassword.request;
          "authelia/session_secret".request = config.shb.authelia.secrets.sessionSecret.request;
          "authelia/storage_encryption_key".request = config.shb.authelia.secrets.storageEncryptionKey.request;
          "authelia/hmac_secret".request = config.shb.authelia.secrets.identityProvidersOIDCHMACSecret.request;
          "authelia/private_key".request = config.shb.authelia.secrets.identityProvidersOIDCIssuerPrivateKey.request;
          "authelia/smtp_password".request = config.shb.authelia.smtp.password.request;
        };

        zfs.datasets."safe/authelia-${domain}" = config.shb.authelia.mount;
        zfs.datasets."safe/authelia-redis" = config.shb.authelia.mountRedis;
      };

      # Need to wait on auth endpoint to be available otherwise nginx can fail to start.
      systemd.services."authelia-${domain}" = {
        wants = optionals config.services.dnsmasq.enable ["dnsmasq.service" "nginx.service"];
        after = optionals config.services.dnsmasq.enable ["dnsmasq.service" "nginx.service"];
      };
    })
  ];
}
