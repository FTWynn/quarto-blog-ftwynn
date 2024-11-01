# shell.nix
let
  # We pin to a specific nixpkgs commit for reproducibility.
  # Last updated: 2024-04-29. Check for new commits at https://status.nixos.org.
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/64b80bfb316b57cdb8919a9110ef63393d74382a.tar.gz") {};
in pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (python-pkgs: with python-pkgs; [
      # select Python packages here
      jupyter
      matplotlib
      plotly
      numpy
    ]))
    pkgs.quarto
  ];

  # https://gnat.blog/posts/quarto-venv/index.html to the rescue!
  # Plus the Quarto docs that specify the new ENV variable
  shellHook = ''
    export JUPYTER_PATH=${pkgs.python3Packages.jupyterlab}/share/jupyter
    export PYTHONPATH=$PYTHONPATH:${pkgs.python3Packages.ipykernel}/${pkgs.python3.sitePackages}
    export QUARTO_PYTHON=$QUARTO_PYTHON:${pkgs.python3Packages.ipykernel}/${pkgs.python3.sitePackages}
  '';
}