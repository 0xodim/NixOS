{ inputs, ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.sddm = { config, lib, pkgs, ... }: {
    
    services.displayManager.sddm = {
      enable = true;
      
      # Required to make SDDM work smoothly with Wayland compositors like Hyprland
      wayland.enable = true;

      # Use the absolute path so we don't need to bloat environment.systemPackages
      theme = "${pkgs.sddm-astronaut}/share/sddm/themes/sddm-astronaut-theme";
      
      # Ensures SDDM can consume the propagated qtmultimedia inputs
      extraPackages = [ 
        pkgs.sddm-astronaut 
      ];
    };
  };
}

