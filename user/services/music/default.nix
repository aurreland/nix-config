{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  home.packages = with pkgs; [ mpd mpc-cli ncmpcpp ];

  # Music Player Daemon
  services.mpd = {
    enable = true;
    dataDir = /home/aurel/.config/mpd;
    extraConfig = ''

    '';
  };

  

  # Ncmpcpp
  programs.ncmpcpp = {
    enable = true;  
  };
  
}
