{
  config,
  inputs,
  self,
  ...
}:
let
  nixpkgs-lib = inputs.nixpkgs.lib;
in
{
  imports =
    let
      searchedModuleRoots = [
        ./flake
      ];
    in
    (nixpkgs-lib.pipe searchedModuleRoots [
      (nixpkgs-lib.lists.map nixpkgs-lib.filesystem.listFilesRecursive)
      nixpkgs-lib.lists.flatten
      (nixpkgs-lib.lists.map builtins.toString)
      (nixpkgs-lib.lists.filter (nixpkgs-lib.strings.hasSuffix ".nix"))
    ])
    ++ [
      inputs.flake-parts.flakeModules.easyOverlay
    ];
}
