{config, ...}: {
  shb = {
    forgejo = {
      enable = true;
      subdomain = "forgejo";
      domain = "nyxer.xyz";

      # # ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";
      databasePassword.result = config.shb.sops.secret."forgejo/databasePassword".result;

      # ldap = {
      #   enable = true;
      #   host = "127.0.0.1";
      #   port = config.shb.ldap.ldapPort;
      #   dcdomain = config.shb.ldap.dcdomain;
      #   adminPassword.result = config.shb.sops.secret."forgejo/ldap_admin_password".result;
      # };

      users = {
        "adminUser" = {
          isAdmin = true;
          email = "admin@nyxer.xyz";
          password.result = config.shb.sops.secret."forgejo/adminPassword".result;
        };
        "nyx" = {
          email = "user@nyxer.xyz";
          password.result = config.shb.sops.secret."forgejo/userPassword".result;
        };
      };
    };
  };

  shb.sops.secret."forgejo/adminPassword".request = config.shb.forgejo.users."adminUser".password.request;
  shb.sops.secret."forgejo/userPassword".request = config.shb.forgejo.users."nyx".password.request;
  shb.sops.secret."forgejo/databasePassword".request = config.shb.forgejo.databasePassword.request;
  # shb.sops.secret."forgejo/ldap_admin_password" = {
  #   request = config.shb.forgejo.ldap.adminPassword.request;
  #   settings.key = "ldap-userPassword";
  # };

  shb.ldap = {
    enable = true;
    domain = "nyxer.xyz";
    subdomain = "ldap";
    ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";
    ldapPort = 3890;
    webUIListenPort = 17170;
    dcdomain = "dc=nyxer,dc=xyz";
    ldapUserPassword.result = config.shb.sops.secret."ldap-userPassword".result;
    jwtSecret.result = config.shb.sops.secret."ldap-jwtSecret".result;
  };

  shb.certs.certs.letsencrypt."nyxer.xyz".extraDomains = ["ldap.nyxer.xyz"];
  shb.sops.secret."ldap-userPassword".request = config.shb.ldap.ldapUserPassword.request;
  shb.sops.secret."ldap-jwtSecret".request = config.shb.ldap.jwtSecret.request;
}
