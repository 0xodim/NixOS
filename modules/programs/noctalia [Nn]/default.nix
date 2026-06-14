{ inputs, ... }: {
  
  # 1. The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.noctalia = { pkgs, ... }: {
    imports = [
      inputs.noctalia.homeModules.default 
      ./_dependencies.nix
    ];

    # Declarative GTK 3/4 Theming
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
    gtk4.theme = null;
    };

    # Declarative Qt Theming
    qt = {
      enable = true;
      platformTheme.name = "qtct";
    };


    programs.noctalia-shell = {
      enable = true;
      # Override the package to inject Python and Evolution Data Server for calendar support
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        python3 = pkgs.python3;
        evolution-data-server = pkgs.evolution-data-server;
      };
    };

    # Install the optional recommended tools to your user environment
    # (Combined your qt6ct, cliphist, and wlsunset packages together)
    home.packages = with pkgs; [
      qt6Packages.qt6ct
      cliphist
      wlsunset
      gnome-calendar
    ];
  };

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.noctalia = { config, lib, pkgs, ... }: {
 
    # Hardware services required by Noctalia's widgets
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    
    # Enable the calendar event service
    services.gnome.evolution-data-server.enable = true;

    # Install optional system-level dependencies (like ddcutil and screen sharing portals)
    environment.systemPackages = [
      pkgs.ddcutil
      pkgs.xdg-desktop-portal
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    # Automatically inject the Home Manager settings
    home-manager.sharedModules = [ inputs.self.modules.homeManager.noctalia ];
  };
}
