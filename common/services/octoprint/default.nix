{
  config,
  pkgs,
  ...
}: {
  services.nginx = {
    virtualHosts."octoprint.nyxer.xyz" = {
      forceSSL = true;
      enableACME = true;
      locations = {
        "/" = {
          proxyPass = "http://127.0.0.1:5000/";
          proxyWebsockets = true; # needed to use WebSocket
          extraConfig = "proxy_ssl_server_name on;
          proxy_set_header Host $http_host;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection \" upgrade \";
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Scheme $scheme;
          proxy_http_version 1.1;
          client_max_body_size 0;";
        };
        # "/webcam/" = {
        #   proxyPass = "http://127.0.0.1:8080/";
        # };
      };
    };
  };

  services.octoprint = {
    enable = true;
    user = "octoprint";
    # port = 443;
    openFirewall = true;
    # stateDir = "/var/lib/octoprint";
    extraConfig = {
      # Set server commands for nixos paths
      server.commands = {
        serverRestartCommand = "/run/wrappers/bin/sudo ${pkgs.systemd}/bin/systemctl restart octoprint.service";
        # systemRestartCommand = "/run/wrappers/bin/sudo ${pkgs.systemd}/bin/systemctl reboot";
        # systemShutdownCommand = "/run/wrappers/bin/sudo ${pkgs.systemd}/bin/systemctl poweroff";
      };
    };
  };

  # Make sure octoprint starts after state dir is mounted
  systemd.services = {
    octoprint.after = ["var-lib-octoprint.mount"];
    # nginx.after = ["var-lib-octoprint.mount"];
  };

  networking.firewall.allowedTCPPorts = [5000 5001];

  security.sudo = {
    enable = true;
    extraRules = [
      {
        # Let user octoprint use some systemctl commands NOPASSWD
        users = ["octoprint"];
        commands = [
          # {
          #   command = "${pkgs.systemd}/bin/systemctl reboot";
          #   options = ["NOPASSWD"];
          # }
          # {
          #   command = "${pkgs.systemd}/bin/systemctl poweroff";
          #   options = ["NOPASSWD"];
          # }
          {
            command = "${pkgs.systemd}/bin/systemctl restart octoprint.service";
            options = ["NOPASSWD"];
          }
        ];
      }
    ];
  };
}
