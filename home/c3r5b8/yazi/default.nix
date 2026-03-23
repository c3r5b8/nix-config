{
  programs.yazi = {
    enable = true;

    enableFishIntegration = true;

    settings = {
      manager = {
        ratio = [1 4 3];
        show_hidden = false;
        sort_by = "natural";
        sort_dir_first = true;
        linemode = "size";
      };

      preview = {
        tab_size = 2;
        max_width = 600;
        image_filter = "lanczos3";
      };
    };

    theme = {
      mgr = {
        cwd = {
          fg = "#3daee9";
          bold = true;
        };
        border_style = {fg = "#bdc3c7";};
      };

      tabs = {
        active = {
          fg = "#eff0f1";
          bg = "#3daee9";
          bold = true;
        };
        inactive = {
          fg = "#3daee9";
          bg = "#eff0f1";
        };
        sep_inner = {
          open = "";
          close = "";
        };
        sep_outer = {
          open = "";
          close = "";
        };
      };

      mode = {
        normal_main = {
          fg = "#eff0f1";
          bg = "#3daee9";
          bold = true;
        };
        normal_alt = {
          fg = "#3daee9";
          bg = "#eff0f1";
        };
        select_main = {
          fg = "#eff0f1";
          bg = "#f67400";
          bold = true;
        };
        select_alt = {
          fg = "#f67400";
          bg = "#eff0f1";
        };
      };

      status = {
        overall = {
          fg = "#232629";
          bg = "#eff0f1";
        };
        progress_normal = {
          fg = "#3daee9";
          bg = "#eff0f1";
        };
        progress_error = {
          fg = "#da4453";
          bg = "#eff0f1";
        };
      };

      indicator = {
        parent = {reversed = true;};
        current = {reversed = true;};
      };

      filetype.rules = [
        {
          mime = "image/*";
          fg = "#f67400";
        }
        {
          mime = "{audio,video}/*";
          fg = "#9b59b6";
        }
        {
          mime = "application/{zip,rar,7z*,tar*}";
          fg = "#da4453";
        }
        {
          mime = "application/pdf";
          fg = "#3daee9";
        }
        {
          url = "*/";
          fg = "#3daee9";
        }
        {
          url = "*";
          is = "exec";
          fg = "#27ae60";
        }
      ];
    };
  };
}
