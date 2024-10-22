# Do not modify this file!	It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.	Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
	imports =
		[ (modulesPath + "/installer/scan/not-detected.nix")
		];

	boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.extraModulePackages = [ ];

	fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "size=64M"
      "mode=755"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C22B-6D35";
    fsType = "vfat";
  };

  fileSystems."/persist" = {
    device = "UUID=31f7b817-661e-4b2d-9e42-47e69dfcfd25";
    fsType = "bcachefs";
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/persist/nix";
		depends = [ "/persist" ];
    fsType = "none";
    neededForBoot = true;
    options = [ "bind" ];
  };

  fileSystems."/home/duanin2" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "size=1G"
      "mode=755"
    ];
  };

	swapDevices = [
		{
			device = "/dev/disk/by-uuid/b5b3b653-7279-4684-9ea3-57db34088d94";
			options = [
				"nofail"
			];
			priority = 0;
		}
	];

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp4s0f1.useDHCP = lib.mkDefault true;
	# networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
