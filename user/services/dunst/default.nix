{ pkgs, config, lib, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  services.dunst = {
    enable = true;
    settings = {
      global = {
        origin = "top-right";
        offset = "10x10";
        width = 200;
        height = 100;
        monitor = 0;
        gap_size = 5;
        follow = "none";
        notification_limit = 5;
        corner_radius = 20;
        background = base00;
        foreground = base05;
        frame_color = base04;
      };
      urgency_low = lib.mkForce {
        background = base00;
        foreground = base05;
        frame_color = base04;
      };
      urgency_normal = lib.mkForce {
        background = base00;
        foreground = base05;
        frame_color = base04;
      };
      urgency_critical = lib.mkForce {
        background = base00;
        foreground = base05;
        frame_color = base08;
      };
    
    };

  };

}
