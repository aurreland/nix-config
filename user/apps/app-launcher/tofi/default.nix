{ pkgs, lib, config, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  home.packages = with pkgs; [ tofi ];

  xdg.configFile."tofi/config".text = ''
    width = 100%
    height = 100%
    border-width = 0
    outline-width = 0
    padding-left = 35%
    padding-top = 35%
    result-spacing = 25
    num-results = 5
    font = monospace
    background-color = #000A
    prompt-color = ${base05}
    selection-color = ${base03}
  '';

}
