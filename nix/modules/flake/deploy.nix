{ inputs, ... }:

{
  flake = {
    nixosConfigurations.container = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ({ pkgs, ... }: {
            boot.isContainer = true;

            networking.firewall.allowedTCPPorts = [ 80 ];

            services.httpd = {
              enable = true;
              adminAddr = "morty@example.org";
            };
          })
        ];
    };
  };
}
