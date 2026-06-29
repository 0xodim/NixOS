{ inputs, ... }: {
  flake.nixosConfigurations.ashina = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      ./_hardware-configuration.nix
 
      { networking.hostName = "ashina"; }
      { environment.sessionVariables.NIXOS_OZONE_WL = "1"; }

      # Add the core Home Manager module right here!
      inputs.home-manager.nixosModules.home-manager
     
      inputs.self.modules.nixos.virtualization
      inputs.self.modules.nixos."malware-lab" 
      inputs.self.modules.nixos.sddm
      inputs.self.modules.nixos.sound
      inputs.self.modules.nixos.hyprland
      inputs.self.modules.nixos.kitty
      inputs.self.modules.nixos.rofi
      inputs.self.modules.nixos.chromium
      inputs.self.modules.nixos.ssh
      inputs.self.modules.nixos.nix
      inputs.self.modules.nixos.midori
      inputs.self.modules.nixos.noctalia
      inputs.self.modules.nixos.alsa
      inputs.self.modules.nixos.optimization
      inputs.self.modules.nixos.bluetooth
      inputs.self.modules.nixos.nixvim-config
      inputs.self.modules.nixos.zsh
      inputs.self.modules.nixos.vpn
      inputs.self.modules.nixos.cli-tools
      inputs.self.modules.nixos.vlc
      inputs.self.modules.nixos.sublime-text 
      inputs.self.modules.nixos.nvidia
      inputs.self.modules.nixos.pcmanfm




      { system.stateVersion = "26.11"; }

    ];
  };
}
