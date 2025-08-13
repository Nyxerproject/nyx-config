{pkgs, ...}: {
  environment.etc = {
    "stalwart/mail-pw1".text = "foobar";
    "stalwart/mail-pw2".text = "foobar";
    "stalwart/admin-pw".text = "foobar";
    "stalwart/acme-secret".text = "secret123";
  };

  services.stalwart-mail = {
    enable = true;
    package = pkgs.stalwart-mail;
    openFirewall = true;
    settings = {
      server = {
        hostname = "mx1.nyxer.xyz";
        tls = {
          enable = true;
          implicit = true;
        };
        listener = {
          smtp = {
            protocol = "smtp";
            bind = "[::]:25";
          };
          submissions = {
            bind = "[::]:465";
            protocol = "smtp";
          };
          imaps = {
            bind = "[::]:993";
            protocol = "imap";
          };
          jmap = {
            bind = "[::]:8080";
            url = "https://mail.nyxer.xyz";
            protocol = "jmap";
          };
          management = {
            bind = ["127.0.0.1:8080"];
            protocol = "http";
          };
        };
      };
      lookup.default = {
        hostname = "mx1.nyxer.xyz";
        domain = "nyxer.xyz";
      };
      acme."letsencrypt" = {
        directory = "https://acme-v02.api.letsencrypt.org/directory";
        challenge = "dns-01";
        contact = "user1@nyxer.xyz";
        domains = [
          "nyxer.xyz"
          "mx1.nyxer.xyz"
        ];
        provider = "cloudflare";
        secret = "%{file:/etc/stalwart/acme-secret}%";
      };
      session.auth = {
        mechanisms = "[plain]";
        directory = "'in-memory'";
      };
      storage.directory = "in-memory";
      session.rcpt.directory = "'in-memory'";
      # queue.outbound.next-hop = "'local'";
      queue.strategy.route = "'local'";
      directory."imap".lookup.domains = ["nyxer.xyz"];
      directory."in-memory" = {
        type = "memory";
        principals = [
          {
            class = "individual";
            name = "User 1";
            secret = "%{file:/etc/stalwart/mail-pw1}%";
            email = ["user1@nyxer.xyz"];
          }
          {
            class = "individual";
            name = "postmaster";
            secret = "%{file:/etc/stalwart/mail-pw1}%";
            email = ["postmaster@nyxer.xyz"];
          }
        ];
      };
      authentication.fallback-admin = {
        user = "admin";
        secret = "%{file:/etc/stalwart/admin-pw}%";
      };
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "webadmin.nyxer.xyz" = {
        extraConfig = ''
          reverse_proxy http://127.0.0.1:8080
        '';
        serverAliases = [
          "mta-sts.nyxer.xyz"
          "autoconfig.nyxer.xyz"
          "autodiscover.nyxer.xyz"
          "mail.nyxer.xyz"
        ];
      };
    };
  };
}
