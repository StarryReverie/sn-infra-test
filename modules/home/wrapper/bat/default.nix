{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.bat.basePackage = pkgs.bat;

  wrappers.bat.prependFlags = [
    "--style=-changes,-numbers,-snip"
    "--theme=OneHalfDark"
  ];
}
