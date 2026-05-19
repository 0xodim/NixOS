{ ... }: {
	flake.modules.nixos.nix = { pkgs, ... }: {
		nix.settings.experimental-features = [ "nix-command" "flakes" ];

		environment.systemPackages = [ pkgs.git ];
	};
}
