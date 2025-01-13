{config, ...}: {
  services.ddclient = {
    enable = true;
    protocol = "namecheap";
    username = "nyxerproject";
    # username.result = config.sops.secrets."namecheap_username".result;
    passwordFile = config.sops.secrets."namecheap_password".path;
    domains = ["nyxer.nyx"];
  };
  # sops.secrets."namecheap_username" = {
  #   #mode = "0400";
  #   owner = "nyx";
  #   group = "nyx";
  # };
  sops.secrets."namecheap_password" = {
    #mode = "0400";
    path = "/var/lib/ddclient/secrets";
    #request = config.services.ddclient.passwordFile.request;slj
    owner = "nyx";
    group = "nyx";
  };
  #shb.sops.secret."namecheap_username".request = config.services.ddclient.username.request;
  #shb.sops.secret."namecheap_password".request = config.services.ddclient.passwordFile.request;
}
