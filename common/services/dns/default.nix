{config, ...}: {
  services.ddclient = {
    enable = false;
    protocol = "namecheap";
    username = "nyxer.xyz";
    server = "dynamicdns.park-your-domain.com";
    passwordFile = config.sops.secrets."namecheap_password".path;
    domains = ["nyxer.xyz"];
  };
  # sops.secrets."namecheap_password".path = "/var/lib/ddclient/secrets";
}
