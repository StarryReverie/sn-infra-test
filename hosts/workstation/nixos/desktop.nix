{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.niri.enable = true;
  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    tofi
    swaybg
    keepassxc
    orchis-theme
    nautilus
    dconf-editor
    amberol
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.firefox.enable = true;
}
