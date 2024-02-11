{ config, pkgs, lib, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  programs.discocss = {
    enable = true;
#     discordAlias = true;
#     css = ''
# .theme-dark {
#   --background-primary: ${base00};
#   --background-primary-alt: ${base01};
#   --background-secondary: ${base01};
#   --background-secondary-alt: ${base01};
#   --background-tertiary: ${base00};
# }
#     '';
  };

}
