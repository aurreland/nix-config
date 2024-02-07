{ inputs, outputs, lib, config, pkgs, userSettings, ... }: {

  programs = {
    git = {
      enable = true;
        userName = "aurreland";
        userEmail = userSettings.email;
    };
  };

  home.packages = [ pkgs.gh ];

}
