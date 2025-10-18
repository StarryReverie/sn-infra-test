{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.ripgrep.enable = true;

  programs.ripgrep.arguments = [
    "--smart-case"
    "--glob='!node_modules/**'"
    "--glob='!dist/**'"
    "--glob='!build/**'"
    "--glob='!target/**'"
    "--glob='!venv/**'"
    "--glob='!__pycache__/**'"
    "--glob='!vendor/**'"
    "--glob='!pkg/**'"
    "--glob='!bin/**'"
    "--glob='!_build/**'"
    "--glob='!.stack-work/**'"
    "--glob='!.gradle/**'"
    "--glob='!elm-stuff/**'"
  ];
}
