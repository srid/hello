default:
    @just --list

CONTAINER:="hello"

# Run hoogle
docs:
    echo http://127.0.0.1:8888
    hoogle serve -p 8888 --local

# Run cabal repl
repl *ARGS:
    cabal repl {{ ARGS }}

# Run ghcid -- auto-recompile and run `main` function
run:
    ghcid -T :main

container-deploy:
    sudo nixos-container destroy {{ CONTAINER }}
    sudo nixos-container create --flake . {{ CONTAINER }}
    sudo nixos-container start {{ CONTAINER }}
