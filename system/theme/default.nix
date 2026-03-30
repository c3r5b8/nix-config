{lib, ...}: {
  options.custom.theme = lib.mkOption {
    type = lib.types.enum ["light" "dark"];
    default = "dark";
    description = "global light/dark theme";
  };
  config = {
    custom.theme = lib.mkDefault "light";
    specialisation = {
      dark.configuration = {
        config.custom.theme = "dark";
        config.environment.etc."theme".text = "dark";
      };
    };
  };
}
