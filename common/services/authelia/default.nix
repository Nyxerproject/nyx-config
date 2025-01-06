{config, ...}: {
  shb.authelia = {
    enable = true;
    domain = "nyxer.xyz";
    subdomain = "auth";
    ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";

    ldapHostname = "127.0.0.1";
    ldapPort = config.shb.ldap.ldapPort;
    dcdomain = config.shb.ldap.dcdomain;

    # smtp = {
    #   host = "smtp.eu.mailgun.org";
    #   port = 587;
    #   username = "postmaster@mg.nyxer.xyz";
    #   from_address = "authelia@nyxer.xyz";
    #   password.result = config.shb.sops.secrets."authelia/smtp_password".result;
    # };

    secrets = {
      jwtSecret.result = config.shb.sops.secrets."authelia/jwt_secret".result;
      ldapAdminPassword.result = config.shb.sops.secrets."authelia/ldap_admin_password".result;
      sessionSecret.result = config.shb.sops.secrets."authelia/session_secret".result;
      storageEncryptionKey.result = config.shb.sops.secrets."authelia/storage_encryption_key".result;
      identityProvidersOIDCHMACSecret.result = config.shb.sops.secrets."authelia/hmac_secret".result;
      identityProvidersOIDCIssuerPrivateKey.result = config.shb.sops.secrets."authelia/private_key".result;
    };
  };

  shb.certs.certs.letsencrypt."nyxer.xyz".extraDomains = ["auth.nyxer.xyz"];

  shb.sops.secrets."authelia/jwt_secret".request = config.shb.authelia.secrets.jwtSecret.request;
  shb.sops.secrets."authelia/ldap_admin_password".request = config.shb.authelia.secrets.ldapAdminPassword.request;
  shb.sops.secrets."authelia/session_secret".request = config.shb.authelia.secrets.sessionSecret.request;
  shb.sops.secrets."authelia/storage_encryption_key".request = config.shb.authelia.secrets.storageEncryptionKey.request;
  shb.sops.secrets."authelia/hmac_secret".request = config.shb.authelia.secrets.identityProvidersOIDCHMACSecret.request;
  shb.sops.secrets."authelia/private_key".request = config.shb.authelia.secrets.identityProvidersOIDCIssuerPrivateKey.request;
  shb.sops.secrets."authelia/smtp_password".request = config.shb.authelia.smtp.password.request;
}
