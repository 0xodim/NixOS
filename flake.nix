{
  description = "Dendritic Pattern for NixOS and Darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # 1. ADDED THE NIX-DARWIN INPUT
    darwin = {
      url = "github:LnL7/nix-darwin";
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
      # 2. ADDED APPLE SILICON (aarch64-darwin) TO SUPPORTED SYSTEMS
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      
      imports = [
        # Automatically sets up flake-parts, import-tree, and imports all ./modules
        inputs.flake-file.flakeModules.dendritic
        (inputs.import-tree ./modules)
        inputs.hercules-ci-effects.flakeModule
      ];

      # 3. REGISTERED YOUR MACBOOK AS A SYSTEM OUTPUT
      flake.darwinConfigurations.MacM2 = inputs.darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [ 
          inputs.self.modules.darwin.MacM2
        ];
      };

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
