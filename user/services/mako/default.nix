{ pkgs, config, lib, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  services.mako = lib.mkForce {
    enable = true;
    anchor = "top-right";
    height = 100;
    width = 200;
    backgroundColor = base00;
    borderColor = base04;
    textColor = base05;
    borderSize = 2;
    borderRadius = 10;
    defaultTimeout = 4000;


  };

}
