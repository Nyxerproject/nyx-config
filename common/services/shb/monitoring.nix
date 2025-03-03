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
      shb.user.grafana = {
        uid = 196;
        gid = 986;
      };
      shb.user.loki = {
        uid = 988;
        gid = 985;
      };
      shb.user.netdata = {
        uid = 987;
        gid = 984;
      };

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["grafana.${domain}"];
      shb.monitoring = {
        enable = true;
        inherit domain;
        subdomain = "grafana";
        ssl = config.shb.certs.certs.letsencrypt.${domain};

        contactPoints = ["ibizaman@${domain}"];
        adminPassword.result = config.shb.sops.secret."monitoring/admin_password".result;
        secretKey.result = config.shb.sops.secret."monitoring/secret_key".result;
        smtp = {
          from_address = "grafana@${domain}";
          from_name = "Grafana";
          host = "smtp.mailgun.org";
          port = 587;
          username = "postmaster@mg.${domain}";
          passwordFile = config.shb.sops.secret."monitoring/smtp".result.path;
        };
      };
      shb.sops.secret."monitoring/smtp".request = {
        mode = "0400";
        owner = "grafana";
        group = "grafana";
        restartUnits = ["grafana.service"];
      };
      shb.sops.secret."monitoring/admin_password".request = config.shb.monitoring.adminPassword.request;
      shb.sops.secret."monitoring/secret_key".request = config.shb.monitoring.secretKey.request;

      services.prometheus.scrapeConfigs = [
        {
          job_name = "netdata";
          metrics_path = "/api/v1/allmetrics?format=prometheus&help=yes&source=as-collected";
          static_configs = [
            {
              targets = ["192.168.50.168:19999"];
            }
          ];
        }
      ];

      shb.zfs.datasets."safe/grafana".path = "/var/lib/grafana";
      shb.zfs.datasets."safe/loki".path = "/var/lib/loki";
      shb.zfs.datasets."safe/netdata".path = "/var/lib/netdata";
    })
  ];
}
