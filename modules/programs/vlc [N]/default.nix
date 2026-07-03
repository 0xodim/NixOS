{ ... }: {
  
  flake.modules.nixos.vlc = { pkgs, ... }: {
    
    # Install the VLC media player package
    environment.systemPackages = [ pkgs.vlc ];
    
  };
}
