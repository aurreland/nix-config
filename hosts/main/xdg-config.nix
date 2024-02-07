{ inputs, outputs, lib, config, ... }: {

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    music = "${config.home.homeDirectory}/Media/Music";
    videos = null;
    pictures = "${config.home.homeDirectory}/Media/Pictures";
    templates = null;
    download = "${config.home.homeDirectory}/Media/Downloads";
    documents = "${config.home.homeDirectory}/Media/Documents";
    desktop = null;
    publicShare = null;
  };

}
