{ inputs, ... }: {
  
  # ---------------------------------------------------------
  # The Auxiliary Module (Home Manager context)
  # ---------------------------------------------------------
  flake.modules.homeManager.programming = { pkgs, ... }: {
    

    # Install user-level IDEs and tools
    home.packages = [
      pkgs.antigravity
      pkgs.conda   # <-- Note: This package name is outside the sources and should be verified
    ];

    # Generate the custom Conda launcher for the Antigravity IDE
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

  # ---------------------------------------------------------
  # The Main Module (NixOS context)
  # ---------------------------------------------------------
  flake.modules.nixos.programming = { inputs, pkgs, ... }: {
    
    # Install system-wide programming packages
    environment.systemPackages = [ 
      pkgs.nasm 
      pkgs.opencode
    ];
    
    # Automatically inject the auxiliary Home Manager module into the host system
    home-manager.sharedModules = [ inputs.self.modules.homeManager.programming ];
  };
}
