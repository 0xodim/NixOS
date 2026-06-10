{ inputs, ... }: {
  
  # 1. The Home Manager Context (Shared user settings)
  flake.modules.homeManager.nam = { ... }: {
    # You can move your Zsh, Kitty, and Git configurations in here later if you want!
    home.stateVersion = "23.11"; 
  };

  # 2. The Darwin Context
  flake.modules.darwin.nam = { inputs, ... }: {
    users.users.nam = {
      name = "nam";
      home = "/Users/nam";
    };
    home-manager.users.nam = {
      imports = [ inputs.self.modules.homeManager.nam ];
    };
  };
}

