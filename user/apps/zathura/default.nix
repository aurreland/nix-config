{ pkgs, config, lib, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  services.zathura = {
    enable = true;
    mappings = {
        #"" = "";
    };
    options = {
      default-bg = base00;
      default-fg = base05;
    };
  };

}
