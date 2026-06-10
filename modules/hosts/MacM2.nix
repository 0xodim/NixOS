{ inputs, ... }: {
  # The Darwin Module context for your Mac host
  flake.modules.darwin.MacM2 = {
    
    # 1. IMPORT YOUR FEATURES & HOME MANAGER
    imports = [
      inputs.home-manager.darwinModules.home-manager # Required to use Home Manager on Mac
      inputs.self.modules.darwin.cli-tools
      inputs.self.modules.darwin.kitty
      inputs.self.modules.darwin.zsh
      inputs.self.modules.darwin.brave-browser
    ];

    # 2. CORE SYSTEM SETTINGS
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 7;
    nix.enable = false; 
    system.primaryUser = "nam";   

    # 3. DEFINE YOUR MAC USER DIRECTORY
    users.users.nam = {
      name = "nam";
      home = "/Users/nam";
    };

    # 4. HOME MANAGER BASE SETUP
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.nam = {
      # Home Manager requires a state version (using 23.11 as a safe default)
      home.stateVersion = "23.11"; 
    };
  };
}

