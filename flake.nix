{
  description = "DocSteve Dendritic Pattern for NixOS 25.11";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hercules-ci-effects.url = "github:hercules-ci/hercules-ci-effects";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";
    
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };    

  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      
      imports = [
        # Automatically sets up flake-parts, import-tree, and imports all ./modules
        inputs.flake-file.flakeModules.dendritic
	      (inputs.import-tree ./modules)
        inputs.hercules-ci-effects.flakeModule
      ];

      herculesCI.ciSystems = [ "x86_64-linux" ];
      hercules-ci.flake-update = {
        enable = true;
        when = {
          minute = 00;
          hour = 12;
          dayOfWeek = "Sun"; # Runs automatically every Sunday at 12:00
        };
        autoMergeMethod = "merge";
      };


    };
}
