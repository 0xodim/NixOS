{ pkgs, ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.fonts = { pkgs, ... }: {
    
    fonts.packages = [
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk-sans  
      pkgs.noto-fonts-color-emoji     
      pkgs.iosevka
      pkgs.iosevka-bin          
      pkgs.adwaita-icon-theme
      
      pkgs.nerd-fonts.meslo-lg
    ];

    fonts.fontconfig.defaultFonts = {
      serif = [ "Iosevka Etoile" ];    
      sansSerif = [ "Iosevka Aile" ]; 
      
      monospace = [ "MesloLGS Nerd Font Mono" "Iosevka" ]; 
      emoji = [ "Noto Color Emoji" ];
    };
  };
}