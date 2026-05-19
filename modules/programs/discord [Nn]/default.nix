{ inputs, ... }: {
  # 1. The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.discord = { pkgs, ... }: {
    # Install Discord
    home.packages = [ pkgs.discord ];
  };

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.discord = { ... }: {
 
    home-manager.sharedModules = [ inputs.self.modules.homeManager.discord ];

  };
}
