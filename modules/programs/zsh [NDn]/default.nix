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
        plugins = [ "git" "sudo" "docker" "history" ]; 
        theme = "nicoulaj"; 
      };
    };
  };

  # 2. The Main Module (NixOS context)
  flake.modules.nixos.zsh = { pkgs, inputs, ... }: {
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    home-manager.sharedModules = [ inputs.self.modules.homeManager.zsh ];
  };

  # 3. The Darwin Module (macOS context)
  flake.modules.darwin.zsh = { pkgs, inputs, ... }: {
    # Required for nix-darwin to hook into your Mac's default shell
    programs.zsh.enable = true;
    # Automatically inject your Home Manager settings into the Mac!
    home-manager.sharedModules = [ inputs.self.modules.homeManager.zsh ];
  };
}
