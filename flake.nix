{
  description =  "Flake of Aurel";

  outputs = { self, nixpkgs, home-manager, stylix, ... } @ inputs:
  let
    inherit (self) outputs;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      hostname = "nixos";
      timezone = "Europe/Paris";
      locale = "en_US.UTF-8";
      host = "main";
      profile = "main";
    };

    # ----- USER SETTINGS ----- #
    userSettings = {
      username = "aurel";
      name = "Aurel";
      email = "aurelien.andreo@proton.me";
      dotfilesDir = "~/.nix-config";
      wm = "gnome";
      term = "";
      theme = "ashes";
    };

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#user'
    nixosConfigurations = {
      system = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          inherit userSettings;
          inherit systemSettings;
        };
        modules = [
          (./. + "/profiles"+("/"+systemSettings.profile)+"/configuration.nix")
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#system'
    homeConfigurations = {
      user = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
	        inherit inputs outputs;
	        inherit userSettings;
	        inherit systemSettings;
	      };
        modules = [
          (./. + "/profiles"+("/"+systemSettings.profile)+"/home.nix")
        ];
      };
    };
  };

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Nix-vim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Firefox Addons
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

}
