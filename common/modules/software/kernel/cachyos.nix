{ pkgs, modules, ... }: {
  imports = [
    (modules.iso + /no-zfs.nix)
  ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos-lto;
  chaotic.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };
}
