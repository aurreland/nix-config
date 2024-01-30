{ pkgs, config, lib, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  programs.swaylock = lib.mkForce {
    enable = true;
    settings = {
      color = base00;
      no-unlock-indicator = true;
      tiling = true;
    };
  };

}
