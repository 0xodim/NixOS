{ inputs, ... }: {
  flake.nixosConfigurations.ashina = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ./_hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      { networking.hostName = "ashina"; }
      { environment.sessionVariables.NIXOS_OZONE_WL = "1"; }
      
      # Core Host Features
      inputs.self.modules.nixos.nix
      inputs.self.modules.nixos.hyprland
      inputs.self.modules.nixos.rofi
      inputs.self.modules.nixos.sddm
      inputs.self.modules.nixos.virtualization
      inputs.self.modules.nixos.malware-lab
      inputs.self.modules.nixos.intel
      inputs.self.modules.nixos.nvidia
      inputs.self.modules.nixos.kitty
      inputs.self.modules.nixos.zsh
      inputs.self.modules.nixos.midori





      
      # Additional utilities
      inputs.self.modules.nixos.nixvim-config
      inputs.self.modules.nixos.networkmanager
      inputs.self.modules.nixos.chromium


      { system.stateVersion = "26.11"; }
    ];
  };
}