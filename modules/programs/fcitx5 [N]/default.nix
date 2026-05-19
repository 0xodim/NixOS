{ ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.fcitx5 = { pkgs, ... }: {
    
    # Standard NixOS knowledge (outside provided sources) for configuring fcitx5
    i18n.inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [ 
        qt6Packages.fcitx5-unikey   # Add Vietnamese typing support
        fcitx5-gtk      # GTK application support
      ];
    };
    
  };
}
