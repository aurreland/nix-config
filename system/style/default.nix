{ config, lib, pkgs, stylix, inputs, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;
with config.lib.stylix;

{

  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    autoEnable = true;
    image = ../../wallpaper;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 10;
    };

    fonts = {
        # monospace = {
        #     name = "Fira Code";
        #     package = pkgs.fira-code;
        # };
        # serif = config.stylix.fonts.monospace;
        # sansSerif = config.stylix.fonts.monospace;
        emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji-blob-bin;
        };
        sizes = {
          terminal = 18;
          applications = 12;
          popups = 12;
          desktop = 12;
        };
    };

    targets = {
      console.enable = true;
      gnome.enable = true;
      gtk.enable = true;
      nixvim.enable = true;
      grub.enable = true;
    };
  };

  qt.platformTheme = "gtk3";

}
