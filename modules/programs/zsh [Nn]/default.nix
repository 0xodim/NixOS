{ inputs, ... }: {
  
  # 1. The Auxiliary Module (Home Manager context)
  flake.modules.homeManager.zsh = { pkgs, ... }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;      

      shellAliases = {
        ll = "ls -l";
      };

      oh-my-zsh = {
        enable = true;
        # Add the specific plugins you want to use here:
        plugins = [ "git" "sudo" "docker" "history" ]; 
        theme = "nicoulaj"; 
      };
    };
  };

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.zsh = { pkgs, inputs, ... }: {
    
    # Enable Zsh system-wide so it can be set as a default shell
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Automatically inject the Home Manager settings
    home-manager.sharedModules = [ inputs.self.modules.homeManager.zsh ];
  };
}
