{
  config,
  lib,
  ...
}: let
  inherit (lib) optionals optionalAttrs;
  inherit (config.me) domain;
  # domain = "nyxerproject.xyz";
in {
  options = {me.domain = lib.mkOption {type = lib.types.str;};};

  config = lib.mkMerge [
    (optionalAttrs true {
      shb = {
        certs.certs.letsencrypt.${domain}.extraDomains = ["forgejo.${domain}"];
        forgejo = {
          enable = true;
          subdomain = "forgejo";
          inherit domain;
          ssl = config.shb.certs.certs.letsencrypt."${domain}";
          adminPassword.result = config.shb.sops.secret."forgejo/adminPassword".result;
          databasePassword.result = config.shb.sops.secret."forgejo/databasePassword".result;
          repositoryRoot = "/srv/projects";

          # smtp = {
          #   host = "smtp.eu.mailgun.org";
          #   port = 587;
          #   username = "postmaster@mg.${domain}";
          #   from_address = "authelia@${domain}";
          #   passwordFile = config.shb.sops.secret."forgejo/smtpPassword".result.path;
          # };

          # ldap = {
          #   enable = true;
          #   host = "127.0.0.1";
          #   port = config.shb.ldap.ldapPort;
          #   dcdomain = config.shb.ldap.dcdomain;
          #   adminPassword.result = config.shb.sops.secret."forgejo/ldap_admin_password".result;
          # };

          # sso = {
          #   enable = true;
          #   endpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
          #   clientID = "forgejo";
          #   sharedSecret.result = config.shb.sops.secret."forgejo/ssoSecret".result;
          #   sharedSecretForAuthelia.result = config.shb.sops.secret."forgejo/authelia/ssoSecret".result;
          # };
        };
      };
      services.forgejo.settings.repository.ENABLE_PUSH_CREATE_USER = true;

      # Need to wait on auth endpoint to be available otherwise nginx can fail to start.
      systemd.services."forgejo" = {
        wants = optionals config.services.dnsmasq.enable ["dnsmasq.service" "nginx.service"];
        after = optionals config.services.dnsmasq.enable ["dnsmasq.service" "nginx.service"];
      };

      nix.settings.trusted-users = ["forgejo"];
      users.users.forgejo.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"];
      shb = {
        sops.secret = {
          "forgejo/adminPassword".request = config.shb.forgejo.adminPassword.request;
          "forgejo/databasePassword".request = config.shb.forgejo.databasePassword.request;
          "forgejo/smtpPassword".request = {
            mode = "0400";
            owner = config.services.forgejo.user;
            restartUnits = ["forgejo.service"];
          };
          "forgejo/ldap_admin_password" = {
            request = config.shb.forgejo.ldap.adminPassword.request;
            settings.key = "ldap/user_password";
          };
          "forgejo/ssoSecret".request = config.shb.forgejo.sso.sharedSecret.request;
          "forgejo/authelia/ssoSecret" = {
            request = config.shb.forgejo.sso.sharedSecretForAuthelia.request;
            settings.key = "forgejo/ssoSecret";
          };
        };
        zfs.datasets."safe/forgejo" = config.shb.forgejo.mount;
      };
    })
  ];
}
