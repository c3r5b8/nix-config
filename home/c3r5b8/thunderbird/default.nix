# { config, pkgs, ... }: {
{
  programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
    };
  };
  accounts.email.accounts = {
    olespid = {
      realName = "Oles Pidkaura";
      address = "olespid@gmail.com";
      flavor = "gmail.com";
      primary = true;
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };

    oles2005p = {
      realName = "Oles Pidkaura";
      address = "oles2005p@gmail.com";
      flavor = "gmail.com";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };

    oles2005pid = {
      realName = "Oles Pidkaura";
      address = "oles2005pid@gmail.com";
      flavor = "gmail.com";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };

    c3r5b8t = {
      realName = "Oles Pidkaura";
      address = "c3r5b8t@gmail.com";
      flavor = "gmail.com";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };

    university = {
      realName = "Oles Pidkaura";
      address = "Pidkaura-O@st.zu.edu.ua";
      flavor = "gmail.com";
      thunderbird = {
        enable = true;
        settings = id: {
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
    tangram = {
      realName = "Oles Pidkaura";
      address = "oles.pidkaura@tangramltd.com";
      userName = "oles.pidkaura@tangramltd.com";

      imap = {
        host = "mail.tanhost.com";
        port = 993;
        tls.enable = true;
      };

      smtp = {
        host = "mail.tanhost.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      thunderbird = {
        enable = true;
      };
    };
  };
}
