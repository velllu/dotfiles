{ config, ... }:

{
  config = {
    users.users."${config.vellu.userData.username}" = {
      isNormalUser = true;
      description = config.vellu.userData.fullname;
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "corectrl" ];
    };

    home-manager.users."${config.vellu.userData.username}" = {
      home.stateVersion = config.vellu.userData.nixosVersion;
    };
  };
}
