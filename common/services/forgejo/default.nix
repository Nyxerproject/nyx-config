{config, ...}: {
  shb = {
    forgejo = {
      enable = true;
      subdomain = "forgejo";
      domain = "nyxer.xyz";
      ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";
      users = {
        "adminUser" = {
          isAdmin = true;
          email = "admin@nyxer.xyz";
          password.result = config.shb.hardcodedsecret.forgejoAdminPassword.result;
        };
        "nyx" = {
          email = "user@nyxer.xyz";
          password.result = config.shb.hardcodedsecret.forgejoUserPassword.result;
        };
      };
    };
  };

  shb.hardcodedsecret."forgejo/admin/password" = {
    request = config.shb.forgejo.users."theadmin".password.request;
  };

  shb.hardcodedsecret."forgejo/user/password" = {
    request = config.shb.forgejo.users."theuser".password.request;
  };

  # services.forgejo.settings.repository.ENABLE_PUSH_CREATE_USER = true;
  # shb.sops.secret = {
  #   "forgejo/adminPassword".request = config.shb.forgejo.adminPassword.request;
  #   "forgejo/databasePassword".request = config.shb.forgejo.databasePassword.request;
  #   "forgejo/smtpPassword".request = {
  #     mode = "0400";
  #     owner = config.services.forgejo.user;
  #     restartUnits = ["forgejo.service"];
  #   };
  #   "forgejo/ldap_admin_password" = {
  #     request = config.shb.forgejo.ldap.adminPassword.request;
  #     settings.key = "ldap/user_password";
  #   };
  #   "forgejo/ssoSecret".request = config.shb.forgejo.sso.sharedSecret.request;
  #   "forgejo/authelia-ssoSecret" = {
  #     request = config.shb.forgejo.sso.sharedSecretForAuthelia.request;
  #     settings.key = "forgejo/ssoSecret";
  #   };
  # };
  # shb.zfs.datasets."safe/forgejo" = config.shb.forgejo.mount;
}
