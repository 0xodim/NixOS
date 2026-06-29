{ inputs, ... }: {
  flake.nixosConfigurations.okami = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    
    modules = [
      # Import the hidden hardware config
      ./_hardware-configuration.nix
      
      # IMPORT THE CORE HOME MANAGER MODULE HERE:
      inputs.home-manager.nixosModules.home-manager
      
      # Pull your features from your Dendritic library!
      inputs.self.modules.nixos.amd         
      inputs.self.modules.nixos.sddm
      inputs.self.modules.nixos.sound
      inputs.self.modules.nixos.hyprland
      inputs.self.modules.nixos.kitty
      inputs.self.modules.nixos.rofi
      inputs.self.modules.nixos.chromium
      inputs.self.modules.nixos.ssh
      inputs.self.modules.nixos.nix
      inputs.self.modules.nixos.mido 
      inputs.self.modules.nixos.noctalia
      inputs.self.modules.nixos.alsa    
      inputs.self.modules.nixos.optimization
      inputs.self.modules.nixos.bluetooth
      inputs.self.modules.nixos.nixvim-config 
      inputs.self.modules.nixos.zsh
      inputs.self.modules.nixos.vpn
      inputs.self.modules.nixos.antigravity
      inputs.self.modules.nixos.obsidian    
      inputs.self.modules.nixos.fonts        
      inputs.self.modules.nixos.pcmanfm
      inputs.self.modules.nixos.cli-tools
      inputs.self.modules.nixos.anaconda
      inputs.self.modules.nixos.fcitx5
      inputs.self.modules.nixos.discord
      inputs.self.modules.nixos.spotify
      inputs.self.modules.nixos.steam
      inputs.self.modules.nixos.thinkfan
      inputs.self.modules.nixos.vlc      
      inputs.self.modules.nixos.opencode
      inputs.self.modules.nixos.sublime-text
      inputs.self.modules.nixos.libreoffice
      inputs.self.modules.nixos.nasm
      inputs.self.modules.nixos.cybersecurity
      inputs.self.modules.nixos.homelab


      # Essential Host Baseline Settings
      ({ ... }: {
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;
        networking.networkmanager.enable = true;
        system.stateVersion = "26.11"; 

        # NEW: AMD GPU Hardware Quirk: Force 90Hz refresh rate system-wide
        boot.kernelParams = [ "amdgpu.dcdebugmask=0x8000" ];
      })
    ];
  };
}
