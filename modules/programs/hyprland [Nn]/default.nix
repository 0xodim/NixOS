{ inputs, ... }: {
  
  # The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.hyprland = { pkgs, ... }: {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang"; 
    };
    
    # Import the separated config file from the same directory
    imports = [ ./_config.nix ];
    
    wayland.windowManager.hyprland.xwayland.enable = true;
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";             # Tells Electron/Chromium apps to use native Wayland
      WLR_NO_HARDWARE_CURSORS = "1";    # Fixes invisible cursors on some GPUs (especially Nvidia)
    };

    home.pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };

      home.packages = [
        pkgs.hyprshot
        pkgs.hyprpaper
        pkgs.wdisplays
        # You can add other tools here later
    ];
  };

   

  # The Main Module (NixOS context)
  flake.modules.nixos.hyprland = { config, lib, pkgs, ... }: {
    programs.hyprland.enable = true;
    
    # Automatically inject the auxiliary Home Manager module into the host system!
    home-manager.sharedModules = [ inputs.self.modules.homeManager.hyprland ];
  };
}
