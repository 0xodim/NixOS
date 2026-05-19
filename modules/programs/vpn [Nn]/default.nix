{ inputs, ... }: {
  
  flake.modules.homeManager.vpn = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    home.packages = [
      pkgs.openvpn    
      pkgs.cloudflare-warp    
    ];
  };

  flake.modules.nixos.vpn = { pkgs, inputs, ... }: {
    
    nixpkgs.config.allowUnfree = true;
    services.cloudflare-warp.enable = true;
    home-manager.sharedModules = [ inputs.self.modules.homeManager.vpn ];

  };
}
