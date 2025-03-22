# hello

Just a Hello World web app in Haskell for various demo purposes.

## Running

```sh
nix run . -- --host 0.0.0.0 --port 8080
```

## Container

Based on [wiki](https://wiki.nixos.org/wiki/NixOS_Containers#Define_and_create_nixos-container_from_a_Flake_file)

```sh
sudo nixos-container create --flake . hello
# Note down the container IP here ^
sudo nixos-container start hello
# Now, curl http://<container_ip>
```

You can now use `just container-deploy` to deploy the new configuration.
