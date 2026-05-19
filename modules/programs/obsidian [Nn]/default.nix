{ inputs, ... }: {
  
  # The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.obsidian = { pkgs, ... }: {
    
    # Explicitly allow unfree/proprietary software for Obsidian
    nixpkgs.config.allowUnfree = true;

    home.packages = [
      pkgs.obsidian
    ];
  };

  # The Main Module (NixOS context)
  flake.modules.nixos.obsidian = { inputs, ... }: {
    
    # Automatically inject the auxiliary Home Manager module into the host system
    home-manager.sharedModules = [ inputs.self.modules.homeManager.obsidian ];
  };
}
