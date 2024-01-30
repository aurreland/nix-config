{ config, pkgs, lib, ... }:

with config.lib.stylix.colors.withHashtag;
with config.stylix.fonts;

{

  home.packages = with pkgs; [
    heroic
  ];

  xdg.configFile."heroic/custom-theme/custom.css".text = ''
body.custom {
    /*
    * custom variables to be more expressive about what the colors actually set.
    * (not that heroic folks did a bad job naming these!)
    */
    --text: ${base05};
    --custom-accent: ${base04};
    --custom-accent-hover: ${base03};
    --background: ${base00};
    --secondary-background: ${base01};

    --button-background: ${base01};
    --button-text: ${base05};

    --box-shadow-color: #1b1b1b;
    --secondary-box-shadow-color: #202020;
    --tertiary-box-shadow-color: #5a5a59;

    --box-shadow: 0 0 0 1px var(--box-shadow-color);
    --secondary-box-shadow: var(--box-shadow-color);

    --border-radius: var(--space-xs);


    --accent: var(--text);
    /*The text in the navbar, of the selected element*/
    --accent-overlay: #fefefe;
    /*The text in the navbar, which isn't selected*/
    --navbar-accent: var(--text);

    /*the color of the divider*/
    --divider: var(--secondary-box-shadow-color);

    --body-background: var(--background);
    --background-darker: var(--background);
    --current-background: var(--background);
    --navbar-background: var(--secondary-background);
    --navbar-active-background: var(--custom-accent);
    --gradient-body-background: var(--background);
    --input-background: var(--secondary-background);
    --modal-background: var(--background);
    --modal-border: var(--box-shadow-color);
    --download-button: #44475a;
    --download-button-overlay: ${base03};
    --success: var(--custom-accent);
    --success-hover: var(--custom-accent-hover);
    --primary: var(--custom-accent);
    --primary-hover: var(--custom-accent-hover);
    --danger: #ff0000;
    --text-title: #00ddff;
    --icons-background: var(--secondary-background);
    --osk-background: var(--background);
    --osk-button-background: var(--secondary-background);
    --osk-button-border: #ffffffff;
  }

body.adwaita .Field>input,
body.adwaita select,
body.adwaita .gameCard,
body.adwaita .gameCard>span,
body.adwaita .SearchBar,
body.adwaita .progressHeader,
body.adwaita .dmItemList
{
  box-shadow: var(--box-shadow) !important;
}

body.adwaita .store-icon {
  background: none;
}

body.adwaita .Sidebar {
  box-shadow: 1px 0 0 0 var(--box-shadow-color);
}

body.adwaita .divider {
  height: 1px;
  margin: var(--space-3xs) 0 !important;
}

body.adwaita .dmItemList {
  border: none;
}

body.adwaita .downloadManagerListItem {
  border-top: none !important;
  box-shadow: 0 -1px 0 0 var(--tertiary-box-shadow-color);

  margin: 0;
  padding: var(--space-md) var(--space-sm-fixed);
}

body.adwaita .numberOfgames {
  background: none;
}

body.adwaita .SearchBar,
body.adwaita .gameCard,
body.adwaita .Field>input,
body.adwaita select,
body.adwaita .progressHeader,
body.adwaita .dmItemList,
body.adwaita .svg-button
{
  border-radius: var(--border-radius);
}

body.adwaita .toggle,
body.adwaita .gameConfigContainer .titleWrapper .settings-icon {
  color: var(--button-text) !important;
  background: var(--button-background) !important;
}


/*
* The filters and simmilar stuff in the Library thingie
*/



body.adwaita .Header__filters {
  height: 100%;
  min-height: 35px;
}

body.adwaita .platformFilters {
  margin: 0;
}

body.adwaita .storeFilter {
  margin: auto 24px;
}

body.adwaita *:has(>.FormControl) {
  height: 100%;
}

body.adwaita .FormControl {
  height: 100%;

  background: var(--button-background);
  color: var(--button-text);
  box-shadow: var(--box-shadow);
  border-radius: var(--border-radius);
}

body.adwaita .FormControl .FormControl__button:first-child {
  border-radius: var(--border-radius) 0 0 var(--border-radius) !important;
}

body.adwaita .FormControl .FormControl__button:last-child {
  border-radius: 0 var(--border-radius) var(--border-radius) 0 !important;
}

body.adwaita .FormControl__button:hover,
body.adwaita .FormControl__button.active  {
  background: var(--secondary-background) !important;
}

body.adwaita .ActionIcons .FormControl__button>svg{
  margin: auto;
}


/*
* All default Buttons,
* and their hovering
*/
body.adwaita *:not(.submenu)>.button,
body.adwaita .sideloadGameButton,
body.adwaita .titleWrapper .svg-button,
body.adwaita .game-actions  {
  background: var(--button-background);
  color: var(--button-text);
  box-shadow: var(--box-shadow);

  border-radius: var(--border-radius);
}

body.adwaita *:not(.submenu).button:hover,
body.adwaita .sideloadGameButton:hover,
body.adwaita .titleWrapper .svg-button:hover,
body.adwaita .titleWrapper .settings-icon:hover {
  background: var(--secondary-background) !important;
  color: var(--button-text);
}
  '';

}

