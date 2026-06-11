{ ... }: {
  
  # The Darwin Context (macOS)
  flake.modules.darwin.davinci = { ... }: {
    
    homebrew = {
      enable = true;
      casks = [ 
        "davinci-resolve" 
      ];
    };
    
  };
}