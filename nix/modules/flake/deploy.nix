{ inputs, ... }:

let
  system = "x86_64-linux";
  hello = inputs.self.packages.${system}.hello;
in
{
  flake = {
    nixosConfigurations.container = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules =
        [
          ({ pkgs, ... }: {
            boot.isContainer = true;

            networking.firewall.allowedTCPPorts = [ 80 ];

            # Add hello service to systemd
            systemd.services.hello = {
              description = "Hello World";
              wantedBy = [ "multi-user.target" ];
              serviceConfig = {
                ExecStart = "${hello}/bin/hello --host 0.0.0.0 --port 80";
              };
            };
          })
        ];
    };
  };
}
