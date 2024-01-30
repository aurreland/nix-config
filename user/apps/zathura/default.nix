{ pkgs, config, lib, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  programs.zathura = lib.mkForce {
    enable = true;
    mappings = {
        f = "toggle_fullscreen";
        "[fullscreen] f" = "toggle_fullscreen";
        u = "scroll half-up";
        d = "scroll half-down";
        D = "toggle_page_mode";
        r = "reload";
        R = "rotate";
        K = "zoom in";
        J = "zoom out";
        p = "print";
        g = "goto top";
    };
    options = {
      default-bg = base00;
      default-fg = base05;
      statusbar-bg = base01;
      statusbar-fg = base05;
      inputbar-bg = base00;
      inputbar-fg = base05;
      completion-highlight-bg = base01;
      completion-highlight-fg = base03;
      highlight-color = base04;
      highlight-active-color = base03;
      adjust-open = "best-fit";
      sandbox = "none";
      statusbar-h-padding = 0;
      statusbar-v-padding = 0;
      age-padding = 1;
      selection-clipboard = "clipboard";
    };
  };

}
