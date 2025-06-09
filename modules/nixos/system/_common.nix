{lib, ...}: {
  options.mySystem = {
    homeManagerProfiles = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [];
      description = ''
        A list of home-manager profiles to be automatically imported for users
        on this system.
      '';
      # merge = lib.mkMerge lib.flatten;
    };
  };
}
