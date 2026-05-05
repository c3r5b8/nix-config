{config, ...}: let
  hostname = config.networking.hostName;
in {
  sops.secrets = {
    "syncthing/${hostname}/key" = {
      owner = config.services.syncthing.user;
      group = config.services.syncthing.group;
      mode = "0600";
    };
    "syncthing/${hostname}/cert" = {
      owner = config.services.syncthing.user;
      group = config.services.syncthing.group;
      mode = "0600";
    };
  };
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "c3r5b8";
    group = "users";

    key = config.sops.secrets."syncthing/${hostname}/key".path;
    cert = config.sops.secrets."syncthing/${hostname}/cert".path;

    settings = {
      devices = {
        "shaula" = {id = "NMOAFEJ-JQQ3GP6-BXQHPFR-KKTNQJM-EGBEXQ2-RGSMKHA-OREPZKU-R5BH4Q2";};
        "sargas" = {id = "BWOM2WU-ZRTTBHK-XOP4L4W-SFKKH7W-JMZGCR3-VQANVTU-QKHRWVQ-G2OMZQQ";};
        "antares" = {id = "DARR3YD-Z3FLLZI-6DLRNKW-AZZHC6C-GZNVNUC-WGX7S4V-OGQ356A-BUXRKA3";};
        "acrab" = {id = "QH3E5AJ-KS6U7QT-SGTVYOA-SQKVTKB-IV26TWG-WKUXQFT-WAAKG7K-SUBEKAU";};
        "husky" = {id = "BF6Q5ZI-7YR64WX-OSA4YYG-YG36GLC-M5N4I5L-NUFYW5L-MT2AA3G-L7ZMXQD";};
      };
      options = {
        localAnnounceEnabled = true;
        urAccepted = -1;
      };

      folders = {
        "notes" = {
          path = "/home/c3r5b8/docs/notes";
          devices = ["shaula" "sargas" "antares" "acrab" "husky"];
        };
      };
    };
    overrideDevices = true;
    overrideFolders = true;
  };
}
