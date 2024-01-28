{ config, lib, pkgs, inputs, ... }: {

  programs.qutebrowser = {
    enable = true;
    aliases = {

    };
    keyBindings = {
      normal = {
        "<Ctrl-v>" = "spawn mpv {url}";
        #"<F1>" = mkMerge [
        #  "config-cycle tabs.show never always"
        #  "config-cycle statusbar.show in-mode always"
        #  "config-cycle scrolling.bar never always"
        #];                                                                                                                                                                         
      };                                                                                                                                                                           
      prompt = {                                                                                                                                                                   
        "<Ctrl-y>" = "prompt-yes";                                                                                                                                                 
      };                                                                                                                                                                           
    };
    searchEngines = {
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      ns = "https://search.nixos.org/packages?channel=23.11&from=0&size=50&sort=relevance&type=packages&query={}";
      nw = "https://nixos.wiki/index.php?search={}";
      g = "https://www.google.com/search?hl=en&q={}";
      y = "https://www.youtube.com/results?search_query={}";
    };
      
  };

}