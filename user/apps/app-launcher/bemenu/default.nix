{ inputs, outputs, lib, config, pkgs, ... }: {

  programs.bemenu = {
    enable = true;
    settings = {
      #width = 600;
      #height = 400;
      #mode = "drun";
    };
  };

}