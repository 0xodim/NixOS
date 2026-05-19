{ inputs, ... }: {
  
  # The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.antigravity = { pkgs, ... }: {
    
    # Explicitly allow unfree/proprietary software for the IDE
    nixpkgs.config.allowUnfree = true;

    home.packages = [
      pkgs.antigravity
    ];
  };

  # The Main Module (NixOS context)
  flake.modules.nixos.antigravity = { inputs, ... }: {
    
    # Automatically inject the auxiliary Home Manager module into the host system
    home-manager.sharedModules = [ inputs.self.modules.homeManager.antigravity ];
  };
}
