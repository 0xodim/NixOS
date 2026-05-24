{ inputs, ... }: {
  
  # The Main Module (NixOS context)
  flake.modules.nixos.sddm = { config, lib, pkgs, ... }: 
  let
    # Override the theme to copy the nocursor base and append custom settings
    custom-sddm-theme = pkgs.where-is-my-sddm-theme.overrideAttrs (oldAttrs: {
      installPhase = oldAttrs.installPhase + ''
        # 1. Copy the nocursor configuration as the baseline
        cp $out/share/sddm/themes/where_is_my_sddm_theme/example_configs/classic_nocursor.conf $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf.user
        
        # 2. Append your specific user, session, and font settings to the bottom of the file
        cat <<EOF >> $out/share/sddm/themes/where_is_my_sddm_theme/theme.conf.user
        
        # Show sessions and users
        showSessionsByDefault=true
        showUsersByDefault=true
        showUserRealNameByDefault=false


        # Lower password font size (default is 96)
        passwordFontSize=48
        EOF
      '';
    });
  in {

    # Make sure the overridden theme is in systemPackages as required by NixOS
    environment.systemPackages = [ custom-sddm-theme ];

    services.displayManager.sddm = {
      enable = true;
      
      # Explicitly use the Qt6 version of SDDM
      package = pkgs.kdePackages.sddm;

      # Wayland, HiDPI, and Numlock settings
      wayland.enable = true;
      enableHidpi = true;
      settings = {
        General = {
          DisplayServer = "wayland";
        };
      };

      # Point to the main theme folder using our custom overridden package
      theme = "${custom-sddm-theme}/share/sddm/themes/where_is_my_sddm_theme";
      
      # Inject the custom theme and qt5compat dependency so SDDM can consume them
      extraPackages = [ 
        custom-sddm-theme
        pkgs.kdePackages.qt5compat
        pkgs.adwaita-icon-theme
      ];
    };
  };
}
