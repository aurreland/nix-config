{ inputs, outputs, lib, config, pkgs, username, email, ... }: {
  
  programs = {
    git = {
      enable = true;
        userName = "aurreland";
        userEmail = email;
    };
  };
  
  home.packages = [ pkgs.gh ];

}