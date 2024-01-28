{
  description =  "Flake of Aurel";

  outputs = { self, nixpkgs, home-manager, stylix, dwl-source, yambar-source, ... } @ inputs: 
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
    hostname = "nixos";
    timezone = "Europe/Paris";
    locale = "en_US.UTF-8";
    host = "main";
    profile = "main";
    
    # ----- USER SETTINGS ----- #
    username = "aurel";
    name = "Aurel";
    email = "aurelien.andreo@proton.me";
    dotfilesDir = "~/.nix-config";
    wm = "hyprland";

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
          inherit username;
          inherit hostname;
          inherit timezone;
          inherit locale;
          inherit name;
          inherit wm;
          inherit host;
          inherit profile;
        };
        modules = [
          (./. + "/profiles"+("/"+profile)+"/configuration.nix")
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
	        inherit username;
          inherit email;
	        inherit host;
	        inherit profile;
          inherit wm;
          inherit dotfilesDir;
	      };
        modules = [
          (./. + "/profiles"+("/"+profile)+"/home.nix")
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

    dwl-source = {
      url = "github:djpohly/dwl/eda0613cc4c657a4d4f0165aa8ccd75108545981"; 
      flake = false;
    };
    yambar-source = {
      url = "git+https://codeberg.org/dnkl/yambar";
      flake = false;
    };


    #nix-gaming = {
    #  url = "github:fufexan/nix-gaming";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
  };

}
