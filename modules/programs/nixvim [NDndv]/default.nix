{ inputs, pkgs, ... }: {
  
  # 1. The Nixvim Context (Where you configure Neovim declaratively)
  flake.modules.nixvim.nixvim-config = { pkgs, ... }: {
    # Force 2-space tabs
    opts = {
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
    };

    # Enable standard plugins declaratively
    plugins = {
      web-devicons.enable = true;
      lualine.enable = true;
      treesitter.enable = true;
      telescope.enable = true;
    };

    # <-- Install custom community themes -->
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "mellifluous";
        src = pkgs.fetchFromGitHub {
          owner = "ramojus";
          repo = "mellifluous.nvim";
          rev = "main";
          hash = "sha256-EHYQyIvWTPfXop4gTw4pL7+vXDeanRxMBjbTf7/1tV8=";
        };
      })
      
      (pkgs.vimUtils.buildVimPlugin {
        name = "kanagawa-paper";
        src = pkgs.fetchFromGitHub {
          owner = "thesimonho";
          repo = "kanagawa-paper.nvim";
          rev = "master"; 
          hash = "sha256-yzu0EvZseFlLB1Flho6WigMnuLL3inLIflxPU3LUPv0="; 
        };
      })

      (pkgs.vimUtils.buildVimPlugin {
        name = "rasmus";
        src = pkgs.fetchFromGitHub {
          owner = "kvrohit";
          repo = "rasmus.nvim";
          rev = "main";
          hash = "sha256-MWc6zzMGZ6OceZGbx2qmuHe9FvIUXK1rtb+yIsfRokY=";
        };
      })
    ];

    # Set the active theme (Change this to "kanagawa-paper" or "rasmus" or "mellifluous" to switch)
    colorscheme = "kanagawa-paper"; 
  };

  # 2. The Auxiliary Module (Home Manager context)
  # NOTICE: Removed 'inputs' from the arguments here!
  flake.modules.homeManager.nixvim-config = { ... }: {
    # Import the official Nixvim Home Manager module
    imports = [ inputs.nixvim.homeModules.nixvim ];
    
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      
      # Inherit the Nixvim configuration we built above
      imports = [ inputs.self.modules.nixvim.nixvim-config ];
    };
  };

  # 3. The Main Module (NixOS context)
  # NOTICE: Removed 'inputs' from the arguments here!
  flake.modules.nixos.nixvim-config = { ... }: {
    # Automatically inject the Home Manager settings system-wide
    home-manager.sharedModules = [ inputs.self.modules.homeManager.nixvim-config ];
  };

  # 4. The Darwin Context (macOS context)
  flake.modules.darwin.nixvim-config = { ... }: {
    # Inject the exact same Home Manager settings into your Mac!
    home-manager.sharedModules = [ inputs.self.modules.homeManager.nixvim-config ];
  };

}
