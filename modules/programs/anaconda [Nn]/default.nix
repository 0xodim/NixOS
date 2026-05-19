{ inputs, ... }: {
  
  # The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.anaconda = { pkgs, ... }: {
    
    # Explicitly allow unfree software just in case you use proprietary conda packages
    nixpkgs.config.allowUnfree = true;

    home.packages = [
      pkgs.conda   # <-- Note: This package name is outside the sources and should be verified
    ];
  };

  # The Main Module (NixOS context)
  flake.modules.nixos.anaconda = { inputs, ... }: {
    
    # Automatically inject the auxiliary Home Manager module into the host system
    home-manager.sharedModules = [ inputs.self.modules.homeManager.anaconda ];
  };
}

