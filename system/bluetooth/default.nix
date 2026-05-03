{
  services.blueman = {
    enable = true;
    withApplet = false;
  };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
