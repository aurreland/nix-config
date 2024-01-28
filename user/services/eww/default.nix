{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [ eww-wayland libnotify socat jq file pavucontrol flac ffmpeg ];

  xdg.configFile."eww/colors.scss".text = ''

    $background: #${config.lib.stylix.colors.base00};
    $background2: #${config.lib.stylix.colors.base01};
    $text: #${config.lib.stylix.colors.base05};
    $text2: #${config.lib.stylix.colors.base04};
    $text3: #${config.lib.stylix.colors.base03};
    $font-size: 20px;

  '';

  xdg.configFile."eww" = {
    recursive = true;
    source = ./eww-config;
  };

  xdg.configFile."eww/scripts" = {
    source = ./scripts;
    executable = true;
  };

}