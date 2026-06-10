{ inputs, ... }: {
  # The Darwin Module context for your Mac host
  flake.modules.darwin.MacM2 = {
    
    # 1. IMPORT YOUR FEATURES & HOME MANAGER
    imports = [
      inputs.home-manager.darwinModules.home-manager 
      inputs.self.modules.darwin.nam
      inputs.self.modules.darwin.cli-tools
      inputs.self.modules.darwin.kitty
      inputs.self.modules.darwin.nixvim-config
      inputs.self.modules.darwin.zsh
      inputs.self.modules.darwin.brave-browser
      inputs.self.modules.darwin.amethyst      

    ];

    # 2. CORE SYSTEM SETTINGS
    nixpkgs.hostPlatform = "aarch64-darwin";
    system.stateVersion = 7;
    nix.enable = false; 
    system.primaryUser = "nam";   
  };
}
