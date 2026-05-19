{ pkgs, ... }: {
  
  # The Main Module (NixOS context) using the Simple Aspect pattern
  flake.modules.nixos.cli-tools = { pkgs, ... }: {
    
    # Explicitly install the packages system-wide
    environment.systemPackages = [
      pkgs.tree
      pkgs.file
      pkgs.zip
      pkgs.unzip
      pkgs.btop
      pkgs.wget
      # You can continue adding any other standard CLI tools you need here!
    ];
    
  };
}
