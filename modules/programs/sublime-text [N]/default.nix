{ ... }: {
  flake.modules.nixos.sublime-text = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;
    
    # Explicitly permit the insecure OpenSSL dependency required by Sublime Text
    nixpkgs.config.permittedInsecurePackages = [
      "openssl-1.1.1w"
    ];

    environment.systemPackages = [ 
      pkgs.sublime4 
    ];
  };
}
