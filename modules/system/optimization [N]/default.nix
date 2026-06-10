{ ... }: {
  
  # The Simple Aspect (NixOS context)
  flake.modules.nixos.optimization = { ... }: {
    
    # Set the System Timezone
    time.timeZone = "Asia/Ho_Chi_Minh";

    # Automatically optimize the Nix store (hardlink identical files)
    nix.settings.auto-optimise-store = true;

    # Automatic Garbage Collection
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    # Limit the bootloader menu to the 10 most recent builds
    boot.loader.systemd-boot = {
      enable = true;
      configurationLimit = 3; 
    };

  };
}
