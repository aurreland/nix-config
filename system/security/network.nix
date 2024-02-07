{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  systemSettings,
  ...
}: {

 # Enable networking
  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ ];
    allowedUDPPortRanges = [
      #{ from = 4000; to = 4007; }
    ];
  };

}
