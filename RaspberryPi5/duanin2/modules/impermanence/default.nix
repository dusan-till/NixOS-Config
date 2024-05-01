{ inputs, ... }: {
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  home.persistence."/persist/home/duanin2" = {
    directories = [
      ".gnupg"
      ".ssh"
    ];
    files = [ ];
    allowOther = true;
  };
}