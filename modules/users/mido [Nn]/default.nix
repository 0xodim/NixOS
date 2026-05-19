{ inputs, ... }: {
  
  # 1. The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.mido = { ... }: {
    
    # Home Manager strictly requires a state version
    home.stateVersion = "25.11";

   programs.git = {
   enable = true;
   settings.user.name = "0xodim";       # Replace with your actual name
   settings.user.email = "minhdoan342002@gmail.com";  # Replace with your actual email
    
    };
  };

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.mido = { config, lib, pkgs, ... }: {
    
    home-manager.backupFileExtension = "backup";
    # Define the system user account
    users.users.mido = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      initialPassword = "password"; # Change this after your first login!
    
    };

    # Activate Home Manager for 'mido' and inject their personal HM auxiliary module
    home-manager.users.mido = {
      imports = [ inputs.self.modules.homeManager.mido ];
    };
  };
}
