{ inputs, pkgs, lib, ... }: {
	services.xserver.desktopManager.plasma6.enable = true;

	services.xserver.displayManager.defaultSession = "plasma";

	environment.systemPackages = with pkgs; [
		(applet-window-title.overrideAttrs (old: let 
			pname = "applet-window-title6";
			version = "master";
		in {
			inherit pname version;

			src = fetchFromGitHub {
				owner = "moodyhunter";
				repo = pname;
				rev = version;
				hash = "sha256-UzyDjmcur5D56w1zjWYcBzmERE1NM/yAmVU9C+2JcPw=";
			};

			meta = with lib; {
				description = "Plasma 6 applet that shows the application title and icon for active window";
				homepage = "https://github.com/moodyhunter/applet-window-title6";
			};
		}))

		(pkgs.callPackage ./sddm-catppuccin.nix { })

		(catppuccin-kde.override {
			flavour = [ "frappe" ];
			accents = [ "green" ];
		})
	] ++ (with pkgs.kdePackages; [
		tokodon
		plasmatube
		kjournald
		bluedevil
		bluez-qt
	]);

	security.pam.services.kwallet = {
		name = "kwallet";
		enableKwallet = true;
	};
}
