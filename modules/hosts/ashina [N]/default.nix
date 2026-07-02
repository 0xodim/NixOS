{ inputs, ... }: {
  flake.nixosConfigurations.ashina = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ./_hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      { networking.hostName = "ashina"; }
      { environment.sessionVariables.NIXOS_OZONE_WL = "1"; }
      { nixpkgs.config.allowUnfree = true; }
    

      
      # Core Host Features
      inputs.self.modules.nixos.nix
      inputs.self.modules.nixos.hyprland
      inputs.self.modules.nixos.rofi
      inputs.self.modules.nixos.sddm
      inputs.self.modules.nixos.virtualization
      inputs.self.modules.nixos.malware-lab
      inputs.self.modules.nixos.w541
      inputs.self.modules.nixos.kitty
      inputs.self.modules.nixos.zsh
      inputs.self.modules.nixos.midori
      
      # Additional utilities
      inputs.self.modules.nixos.nixvim-config
      inputs.self.modules.nixos.chromium

      ({ ... }: {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        networking.networkmanager.enable = true;
        system.stateVersion = "26.11"; 
      })


    ];
  };
}