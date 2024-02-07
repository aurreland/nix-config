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
    musicDirectory = "~/Media/Music";
    dataDir = /home/aurel/.config/mpd;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  # Ncmpcpp
  programs.ncmpcpp = {
    enable = true;
  };

}
