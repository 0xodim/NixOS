{ ... }: {
  # Define the Simple Aspect for the NixOS class
  flake.modules.nixos.chromium = { pkgs, ... }: {
    # Install the Chromium browser
    environment.systemPackages = [ pkgs.chromium ];
  };
}
