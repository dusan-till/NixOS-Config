{ persistDirectory, ... }: {
  programs.direnv = {
    enable = true;

    enableBashIntegration = true;
    enableNushellIntegration = true;
    nix-direnv = {
      enable = true;
    };
  };

  home.persistence.${persistDirectory} = {
    directories = [ ".local/share/direnv" ];
  };
}
