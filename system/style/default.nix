{ config, lib, pkgs, stylix, inputs, userSettings, ... }:
let
  themePath = "../../../themes/"+userSettings.theme+"/"+userSettings.theme+".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../themes/"+("/"+userSettings.theme)+"/backgroundsha256.txt");
in
{

  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    autoEnable = false;

    polarity = themePolarity;

    image = pkgs.fetchurl {
      url = backgroundUrl;
      sha256 = backgroundSha256;
    };

    base16Scheme = ./. + themePath;

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

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
  };

}
