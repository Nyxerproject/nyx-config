{config, ...}: {
  environment.etc."nextcloud-admin-pass".text = "PWD";
  services.nextcloud = {
    settings = let
      prot = "http";
      host = "127.0.0.1";
      dir = "/nextcloud";
    in {
      enable = true;
      configureRedis = true;
      hostName = "localhost";
      config.adminpassFile = "/etc/nextcloud-admin-pass";
      overwriteprotocol = prot;
      overwritehost = host;
      overwritewebroot = dir;
      htaccess.RewriteBase = dir;
      overwrite.cli.url = "${prot}://${host}${dir}/";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) news contacts calendar tasks;
    };
    nginx.virtualHosts."${config.services.nextcloud.hostName}".listen = [
      {
        addr = "127.0.0.1";
        port = 8080; # NOT an exposed port
      }
    ];
    nginx.virtualHosts."localhost" = {
      "^~ /.well-known" = {
        priority = 9000;
        extraConfig = ''
          absolute_redirect off;
          location ~ ^/\\.well-known/(?:carddav|caldav)$ {
            return 301 /nextcloud/remote.php/dav;
          }
          location ~ ^/\\.well-known/host-meta(?:\\.json)?$ {
            return 301 /nextcloud/public.php?service=host-meta-json;
          }
          location ~ ^/\\.well-known/(?!acme-challenge|pki-validation) {
            return 301 /nextcloud/index.php$request_uri;
          }
          try_files $uri $uri/ =404;
        '';
      };
      "/nextcloud/" = {
        priority = 9999;
        extraConfig = ''
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-NginX-Proxy true;
          proxy_set_header X-Forwarded-Proto http;
          proxy_pass http://127.0.0.1:8080/; # tailing / is important!
          proxy_set_header Host $host;
          proxy_cache_bypass $http_upgrade;
          proxy_redirect off;
        '';
      };
    };
  };
}
