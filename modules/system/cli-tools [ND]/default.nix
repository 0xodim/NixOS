{ ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.cli-tools = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.lm_sensors
      pkgs.fzf
      pkgs.tree
      pkgs.file
      pkgs.zip
      pkgs.unzip
      pkgs.btop
      pkgs.wget
      pkgs.nitch
    ];
  };

  # The Darwin Module (macOS context) sharing the same packages!
  flake.modules.darwin.cli-tools = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.fzf
      pkgs.tree
      pkgs.file
      pkgs.zip
      pkgs.unzip
      pkgs.btop
      pkgs.wget
      pkgs.fastfetch
    ];
  };

}

