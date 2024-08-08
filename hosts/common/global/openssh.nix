{
  services.openssh = {
    enable = true;
    openFirewall = true;
  };
  programs.mosh.enable = true;
}
