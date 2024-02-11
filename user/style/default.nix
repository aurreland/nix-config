{ config, lib, pkgs, inputs, userSettings, ... }:
let
  themePath = "../../../themes"+("/"+userSettings.theme+"/"+userSettings.theme)+".yaml";
  themePolarity = lib.removeSuffix "\n" (builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/polarity.txt"));
  backgroundUrl = builtins.readFile (./. + "../../../themes"+("/"+userSettings.theme)+"/backgroundurl.txt");
  backgroundSha256 = builtins.readFile (./. + "../../../themes/"+("/"+userSettings.theme)+"/backgroundsha256.txt");
in
{

  home.file.".currenttheme".text = userSettings.theme;

  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    autoEnable = false;

    polarity = themePolarity;

    image =
    if userSettings.wallpaper
    then ../../wallpaper
    else pkgs.fetchurl {
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
           # name = "Fira Code";
           # package = pkgs.fira-code;
        # };
        # serif = config.stylix.fonts.monospace;
        # sansSerif = config.stylix.fonts.monospace;
        emoji = {
            name = "Noto Color Emoji";
            package = pkgs.noto-fonts-emoji-blob-bin;
        };
        sizes = {
          terminal = 12;
          applications = 12;
          popups = 12;
          desktop = 12;
        };
    };

    targets = {
      kitty.enable = if (userSettings.term == "kitty") then true else false;
      gtk.enable = true;
      hyprland.enable = if (userSettings.wm == "hyprland") then true else false;
      gnome.enable = true;
      fish.enable = true;
      gedit.enable = true;
      nixvim.enable = true;
    };

  };


  xdg.configFile = {
    "qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ./oomox-current.conf.mustache;
      extension = ".conf";
    };
    "Trolltech.conf".source = config.lib.stylix.colors {
      template = builtins.readFile ./Trolltech.conf.mustache;
      extension = ".conf";
    };
    "kdeglobals".source = config.lib.stylix.colors {
      template = builtins.readFile ./Trolltech.conf.mustache;
      extension = "";
    };
    "qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./qt5ct.conf);
  };

  home.packages = with pkgs; [
     qt5ct pkgs.libsForQt5.breeze-qt5
  ];
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
  programs.zsh.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
  programs.bash.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
  qt = {
    enable = true;
    # style.package = pkgs.libsForQt5.breeze-qt5;
    # style.name = "breeze-dark";
  };

}
