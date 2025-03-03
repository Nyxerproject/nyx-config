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
      shb.user.hass = {
        uid = 286;
        gid = 286;
      };

      shb.certs.certs.letsencrypt.${domain}.extraDomains = ["ha.${domain}"];
      shb.home-assistant = {
        enable = true;
        inherit domain;
        subdomain = "ha";
        ssl = config.shb.certs.certs.letsencrypt.${domain};

        config = {
          name = "Skarabox";
          country.source = config.shb.sops.secret."home-assistant/country".result.path;
          latitude.source = config.shb.sops.secret."home-assistant/latitude_home".result.path;
          longitude.source = config.shb.sops.secret."home-assistant/longitude_home".result.path;
          time_zone.source = config.shb.sops.secret."home-assistant/time_zone".result.path;
          unit_system = "metric";
        };

        ldap = {
          enable = true;
          host = "127.0.0.1";
          port = config.shb.ldap.webUIListenPort;
          userGroup = "homeassistant_user";
        };
      };
      shb.sops.secret."home-assistant/country".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
      shb.sops.secret."home-assistant/latitude_home".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
      shb.sops.secret."home-assistant/longitude_home".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
      shb.sops.secret."home-assistant/time_zone".request = {
        mode = "0440";
        owner = "hass";
        group = "hass";
        restartUnits = ["home-assistant.service"];
      };
      services.home-assistant = {
        extraComponents = [
          "accuweather"
          "apple_tv"
          "asuswrt"
          "backup"
          "bluetooth"
          "cast"
          "deluge"
          "esphome"
          "ibeacon"
          "icloud"
          "ipp"
          "jellyfin"
          "kegtron"
          "kodi"
          "nest"
          "nmap_tracker"
          "openweathermap"
          "oralb"
          "overkiz"
          "philips_js"
          "radarr"
          "simplisafe"
          "somfy"
          "somfy_mylink"
          "sonarr"
          "sonos"
          "subaru"
          "tradfri"
          "wled"
          "zha"

          "assist_pipeline"
          "conversation"
          "piper"
          "wake_word"
          "whisper"
          "wyoming"
        ];

        # Need to add them manually by enabling advanced mode in user profile
        # then adding in Settings > Dashboards > Resources:
        #   - /local/nixos-lovelace-modules/mini-graph-card-bundle.js
        #   - /local/nixos-lovelace-modules/mini-media-player-bundle.js
        customLovelaceModules = with pkgs.home-assistant-custom-lovelace-modules; [
          mini-graph-card
          mini-media-player
        ];
        extraPackages = python3Packages: [
          python3Packages.grpcio # Needed for nest
        ];
      };
      users.users.hass.extraGroups = ["dialout"];
      nixpkgs.config.allowUnfreePredicate = pkg:
        builtins.elem (pkgs.lib.getName pkg) [
          "python-nest"
        ];

      shb.zfs.datasets."safe/home-assistant".path = "/var/lib/hass";
    })
  ];
}
