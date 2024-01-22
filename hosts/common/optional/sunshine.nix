{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    sunshine
  ];
  networking.firewall = {
    allowedTCPPorts = [47984 47989 47990 48010];
    allowedUDPPorts = [47998 47999 48000 48002];
  };
}
