{ inputs, outputs, lib, config, pkgs, ... }: {

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        prompt = "'> '";
        icons-enabled = false;
        lines = 10;
        width = 20;
        vertical-pad = 10;
        horizontal-pad = 10;
      };
    };
  };

}
