{config, ...}: {
  shb.authelia = {
    enable = true;
    domain = "nyxer.xyz";
    subdomain = "auth";
    ssl = config.shb.certs.certs.letsencrypt."nyxer.xyz";

    ldapHostname = "127.0.0.1";
    ldapPort = config.shb.ldap.ldapPort;
    dcdomain = config.shb.ldap.dcdomain;

    secrets = {
      jwtSecret.result = config.shb.sops.secret."authelia/jwt_secret".result;
      ldapAdminPassword.result = config.shb.sops.secret."authelia/ldap_admin_password".result;
      sessionSecret.result = config.shb.sops.secret."authelia/session_secret".result;
      storageEncryptionKey.result = config.shb.sops.secret."authelia/storage_encryption_key".result;
      identityProvidersOIDCHMACSecret.result = config.shb.sops.secret."authelia/hmac_secret".result;
      identityProvidersOIDCIssuerPrivateKey.result = config.shb.sops.secret."authelia/private_key".result;
    };
  };

  shb.sops.secret = {
    "authelia/jwt_secret".request = config.shb.authelia.secrets.jwtSecret.request;
    "authelia/ldap_admin_password".request = config.shb.authelia.secrets.ldapAdminPassword.request;
    "authelia/session_secret".request = config.shb.authelia.secrets.sessionSecret.request;
    "authelia/storage_encryption_key".request = config.shb.authelia.secrets.storageEncryptionKey.request;
    "authelia/hmac_secret".request = config.shb.authelia.secrets.identityProvidersOIDCHMACSecret.request;
    "authelia/private_key".request = config.shb.authelia.secrets.identityProvidersOIDCIssuerPrivateKey.request;
    # "authelia/smtp_password".request = config.shb.authelia.smtp.password.request;
  };
}
