{ inputs, ... }: {
  
  # The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.kitty = { ... }: {
    programs.kitty = {
      enable = true;
      settings = {
        window_padding_width = 0;
        background_opacity = "0.90";
        confirm_os_window_close = 0;
        enable_audio_bell = false;
      };

    extraConfig = 
    ''
      include Noctalia.conf
    '';

    };
  };

  # The Main Module (NixOS context)
  flake.modules.nixos.kitty = { ... }: {
    # Inject the Home Manager settings into your system
    home-manager.sharedModules = [ inputs.self.modules.homeManager.kitty ];
  };
}
