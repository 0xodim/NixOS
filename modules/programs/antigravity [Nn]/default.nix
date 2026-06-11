{ inputs, ... }: {
  
  # The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.antigravity = { pkgs, ... }: {
    
    # Explicitly allow unfree/proprietary software for the IDE
    nixpkgs.config.allowUnfree = true;

    # Install the IDE
    home.packages = [
      pkgs.antigravity
    ];

    # Generate the custom Conda launcher
    home.file.".local/share/applications/antigravity-conda.desktop".text = ''
      [Desktop Entry]
      Name=Antigravity (Conda)
      Comment=Gemini Antigravity IDE wrapped with Conda
      # This strings your commands together automatically:
      Exec=conda-shell -c "conda activate base && antigravity"
      Terminal=false
      Type=Application
      Categories=Development;IDE;
    '';
  };

  # The Main Module (NixOS context)
  flake.modules.nixos.antigravity = { inputs, ... }: {
    
    # Automatically inject the combined Home Manager module into the host system
    home-manager.sharedModules = [ inputs.self.modules.homeManager.antigravity ];
  };
}
