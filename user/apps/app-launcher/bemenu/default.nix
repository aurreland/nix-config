{ inputs, outputs, lib, config, pkgs, ... }: {

  programs.bemenu = {
    enable = true;
    settings = {
      line-height = 32;
    };
  };

}
