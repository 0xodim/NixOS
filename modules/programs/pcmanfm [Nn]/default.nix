{ inputs, ... }: {
  
  # The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.pcmanfm = { pkgs, ... }: {
    home.packages = [
      pkgs.pcmanfm   # The actual file manager application
    ];
  };

  # The Main Module (NixOS context)
  flake.modules.nixos.pcmanfm = { inputs, ... }: {
    
    # Enable GVfs, a system-level service required for file managers 
    # to support trash, mounting, and external volumes natively.
    services.gvfs.enable = true; 

    # Automatically inject the auxiliary Home Manager module into the host system
    home-manager.sharedModules = [ inputs.self.modules.homeManager.pcmanfm ];
  };
}
