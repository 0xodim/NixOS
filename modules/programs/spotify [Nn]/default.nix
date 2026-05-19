{ inputs, ... }: {
  # 1. The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.spotify = { pkgs, ... }: {
    # Install Spotify
    home.packages = [ pkgs.spotify ];
    
    # Enable Noctalia's native Spotify theming
    programs.noctalia.settings.templates.spotify = true;
  };

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.spotify = { ... }: {
    home-manager.sharedModules = [ inputs.self.modules.homeManager.spotify ];
  };
}
