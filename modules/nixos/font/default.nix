{
  config,
  lib,
  pkgs,
  ...
}:
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
    source-code-pro
    cascadia-code
  ];

  fonts.fontDir.enable = true;

  fonts.fontconfig = {
    enable = true;
    localConf = builtins.readFile ./fonts.conf;
  };
}
