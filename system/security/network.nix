{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  hostname,
  ...
}: {

 # Enable networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ ];
    allowedUDPPortRanges = [
      #{ from = 4000; to = 4007; }
    ];
  };

}
