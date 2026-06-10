{ ... }: {
  
  # The NixOS Context (Uses standard nixpkgs)
  flake.modules.nixos.brave-browser = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.firefox ];
  };

  # The Darwin Context (Uses native macOS Homebrew Casks)
  flake.modules.darwin.brave-browser = { ... }: {
    homebrew.enable = true; 
    homebrew.casks = [
      "brave-browser"
    ];
  };

}
