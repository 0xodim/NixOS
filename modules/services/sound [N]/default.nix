{ inputs, ... }: {
  
  # 1. The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.sound = { pkgs, ... }: {
    
    # Add the user-space audio tools we discussed earlier
    home.packages = [
      pkgs.pavucontrol   # Your GUI volume mixer
      pkgs.alsa-utils    # Provides alsamixer for hardware toggles
      pkgs.brightnessctl # For toggling your microphone LED
    ];
  }; 

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.sound = { config, lib, pkgs, ... }: {
    
    # Enable PipeWire at the system level 
    # (Note: These specific PipeWire enablement options are standard NixOS 
    # configuration from outside the given sources, so you may want to verify them!)
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Automatically inject the auxiliary Home Manager module into the host system!
    home-manager.sharedModules = [ inputs.self.modules.homeManager.sound ];
  };
}
