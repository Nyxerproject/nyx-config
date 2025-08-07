{ config, ... }:
let
  domain = "nyxer.xyz";
in
{
  # security.acme = {
  #   acceptTerms = true;
  #   certs."nextcloud.${domain}".email = "nxyerproject@gmail.com";
  #   certs."ldap.${domain}".email = "nxyerproject@gmail.com";
  #   certs."forgejo.${domain}".email = "nxyerproject@gmail.com";
  #   certs."auth.${domain}".email = "nxyerproject@gmail.com";
  #   certs."octoprint.${domain}".email = "nxyerproject@gmail.com";
  #
  #   defaults.email = "nxyerproject@gmail.com";
  # };
}
