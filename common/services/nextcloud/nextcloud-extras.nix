# Taken from here: https://github.com/onny/nixos-nextcloud-testumgebung/blob/f97c7e1cd7a995e476cc81f36083dfb21b02e588/nextcloud-extras.nix
{
  config,
  lib,
  options,
  ...
}: let
  inherit
    (lib)
    optionalString
    escapeShellArg
    types
    concatStringsSep
    mapAttrsToList
    mkIf
    mkOption
    mkDefault
    mkForce
    ;

  cfg = config.services.nextcloud;
  fpm = config.services.phpfpm.pools.nextcloud;
  webserver = config.services.${cfg.webserver};
in {
  options = {
    services.nextcloud = {
      ensureUsers = mkOption {
        default = {};
        description = lib.mdDoc ''
          List of user accounts which get automatically created if they don't
          exist yet. This option does not delete accounts which are not listed
          anymore.
        '';
        example = {
          user1 = {
            passwordFile = /secrets/user1-localhost;
            email = "user1@localhost";
          };
          user2 = {
            passwordFile = /secrets/user2-localhost;
            email = "user2@localhost";
          };
        };
        type = types.attrsOf (types.submodule {
          options = {
            passwordFile = mkOption {
              type = types.path;
              example = "/path/to/file";
              default = null;
              description = lib.mdDoc ''
                Specifies the path to a file containing the
                clear text password for the user.
              '';
            };
            email = mkOption {
              type = types.str;
              example = "user1@localhost";
              default = null;
            };
          };
        });
      };

      webserver = mkOption {
        type = types.enum ["nginx" "caddy"];
        default = "nginx";
        description = ''
          Whether to use nginx or caddy for virtual host management.
          Further nginx configuration can be done by adapting <literal>services.nginx.virtualHosts.&lt;name&gt;</literal>.
          See <xref linkend="opt-services.nginx.virtualHosts"/> for further information.
        '';
      };

      extraOCCCommands = mkOption {
        default = "";
        type = types.lines;
        example = "nextcloud-occ app:enable cleanup";
        description = lib.mdDoc ''
          Extra OCC commands which get executed after setup.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.services.nextcloud-ensure-users = {
      enable = true;
      script = ''
        ${optionalString (cfg.ensureUsers != {}) ''
          ${concatStringsSep "\n" (mapAttrsToList (name: cfg: ''
              if ${config.services.nextcloud.occ}/bin/nextcloud-occ user:info "${name}" | grep "user not found"; then
                export OC_PASS="$(cat ${escapeShellArg cfg.passwordFile})"
                ${config.services.nextcloud.occ}/bin/nextcloud-occ user:add --password-from-env "${name}"
              fi
              ${optionalString (cfg.email != null) ''
                ${config.services.nextcloud.occ}/bin/nextcloud-occ user:setting "${name}" settings email "${cfg.email}"
              ''}
            '')
            cfg.ensureUsers)}
        ''}
      '';
      wantedBy = ["multi-user.target"];
      after = ["nextcloud-setup.service"];
    };

    systemd.services.nextcloud-extra-occ-commands = {
      enable = true;
      script = ''
        ${cfg.extraOCCCommands}
      '';
      wantedBy = ["multi-user.target"];
      after = ["nextcloud-setup.service"];
    };

    services.phpfpm.pools.nextcloud.settings = {
      "listen.owner" = webserver.user;
      "listen.group" = webserver.group;
    };

    users.groups.nextcloud.members = ["nextcloud" webserver.user];

    services.nginx = lib.mkIf (cfg.webserver == "caddy") {
      enable = mkForce false;
    };

    services.caddy = lib.mkIf (cfg.webserver == "caddy") {
      enable = mkDefault true;
      virtualHosts."${
        if cfg.https
        then "https"
        else "http"
      }://${cfg.hostName}" = {
        extraConfig = ''
          encode zstd gzip

          root * ${config.services.nginx.virtualHosts.${cfg.hostName}.root}

          redir /.well-known/carddav /remote.php/dav 301
          redir /.well-known/caldav /remote.php/dav 301
          redir /.well-known/* /index.php{uri} 301
          redir /remote/* /remote.php{uri} 301

          header {
            Strict-Transport-Security max-age=31536000
            Permissions-Policy interest-cohort=()
            X-Content-Type-Options nosniff
            X-Frame-Options SAMEORIGIN
            Referrer-Policy no-referrer
            X-XSS-Protection "1; mode=block"
            X-Permitted-Cross-Domain-Policies none
            X-Robots-Tag "noindex, nofollow"
            -X-Powered-By
          }

          php_fastcgi unix/${fpm.socket} {
            root ${config.services.nginx.virtualHosts.${cfg.hostName}.root}
            env front_controller_active true
            env modHeadersAvailable true
          }

          @forbidden {
            path /build/* /tests/* /config/* /lib/* /3rdparty/* /templates/* /data/*
            path /.* /autotest* /occ* /issue* /indie* /db_* /console*
            not path /.well-known/*
          }
          error @forbidden 404

          @immutable {
            path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
            query v=*
          }
          header @immutable Cache-Control "max-age=15778463, immutable"

          @static {
            path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
            not query v=*
          }
          header @static Cache-Control "max-age=15778463"

          @woff2 path *.woff2
          header @woff2 Cache-Control "max-age=604800"

          file_server
        '';
      };
    };
  };
}
