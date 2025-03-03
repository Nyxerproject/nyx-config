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
      shb.user.vaultwarden = {
        uid = 989;
        gid = 987;
      };

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["vaultwarden.${domain}"];
      shb.vaultwarden = {
        enable = true;
        inherit domain;
        subdomain = "vaultwarden";
        ssl = config.shb.certs.certs.letsencrypt.${domain};
        port = 8222;
        authEndpoint = "https://${config.shb.authelia.subdomain}.${config.shb.authelia.domain}";
        databasePassword.result = config.shb.sops.secret."vaultwarden/db".result;
        smtp = {
          host = "smtp.eu.mailgun.org";
          port = 587;
          username = "postmaster@mg.${domain}";
          from_address = "authelia@${domain}";
          password.result = config.shb.sops.secret."vaultwarden/smtp".result;
        };
      };
      shb.sops.secret."vaultwarden/db" = {
        request = config.shb.vaultwarden.databasePassword.request;
      };
      shb.sops.secret."vaultwarden/smtp" = {
        request = config.shb.vaultwarden.smtp.password.request;
      };

      shb.zfs.datasets."safe/vaultwarden" = config.shb.vaultwarden.mount;
      shb.zfs.datasets."safe/postgresql".path = "/var/lib/postgresql";
      systemd.services."restic-backups-vaultwarden_s3_s3.us-west-000.backblazeb2.com_skarabox-backup_vaultwarden.service" = {
        wants = optionals config.services.dnsmasq.enable ["dnsmasq.service"];
        after = optionals config.services.dnsmasq.enable ["dnsmasq.service"];
      };
      systemd.services."restic-backups-vaultwarden_srv_backup_restic_skarabox_vaultwarden.service" = {
        wants = optionals config.services.dnsmasq.enable ["dnsmasq.service"];
        after = optionals config.services.dnsmasq.enable ["dnsmasq.service"];
      };
    })
  ];
}
