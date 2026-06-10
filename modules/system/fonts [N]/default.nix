{ pkgs, ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.fonts = { pkgs, ... }: {
    
    # 1. Install the font packages globally
    fonts.packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans  
      pkgs.noto-fonts-color-emoji     
      pkgs.iosevka
      pkgs.iosevka-bin          
      pkgs.adwaita-icon-theme
    ];

    # 2. Pick which fonts to use as your system defaults
    fonts.fontconfig.defaultFonts = {
      serif = [ "Iosevka Etoile" ];    
      sansSerif = [ "Iosevka Aile" ]; 
      monospace = [ "Iosevka" ]; 
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
