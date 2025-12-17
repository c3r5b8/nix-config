{theme, ...}: {
  imports = [
    ../../home/c3r5b8
  ];
  xdg.configFile."monitors.xml" = {
    source = ./monitors.xml;
  };
}
