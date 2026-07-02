{ inputs, ... }: {
  
  # 1. The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.midori = { ... }: {
    
    # Home Manager strictly requires a state version
    home.stateVersion = "26.05";

   programs.git = {
   enable = true;
   settings.user.name = "0xodim";       # Replace with your actual name
   settings.user.email = "minhdoan342002@gmail.com";  # Replace with your actual email
    
    };
  };

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.midori = { config, lib, pkgs, ... }: {
    
    home-manager.backupFileExtension = "backup";
    # Define the system user account
    users.users.midori = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
      initialPassword = "1"; # Change this after your first login!
    
    };

    # Activate Home Manager for 'midori' and inject their personal HM auxiliary module
    home-manager.users.midori = {
      imports = [ inputs.self.modules.homeManager.midori ];
    };
  };
}
