{ pkgs, ... }: {
  # Dependencies specifically for the Noctalia plugin
  home.packages = [
  
  # SCREENSHOT PLUGINS 
    pkgs.grim
    pkgs.wl-clipboard
    pkgs.swappy
    pkgs.imagemagick
    pkgs.tesseract
    pkgs.xdg-utils
    pkgs.jq
    pkgs.wf-recorder
    pkgs.slurp

  # USB PLUGINS
    pkgs.udisks2       
    pkgs.systemd        
    pkgs.util-linux     
    pkgs.coreutils      

  ];
}
