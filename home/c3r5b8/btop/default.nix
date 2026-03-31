{theme, ...}: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme =
        if theme == "dark"
        then "dark"
        else "light";
    };
    themes = {
      light = ''
        theme[main_bg]="#eff1f5"
        theme[main_fg]="#4c4f69"
        theme[title]="#4c4f69"
        theme[hi_fg]="#1e66f5"
        theme[selected_bg]="#bcc0cc"
        theme[selected_fg]="#1e66f5"
        theme[inactive_fg]="#8c8fa1"
        theme[graph_text]="#dc8a78"
        theme[meter_bg]="#bcc0cc"
        theme[proc_misc]="#dc8a78"
        theme[cpu_box]="#8839ef" #Mauve
        theme[mem_box]="#40a02b" #Green
        theme[net_box]="#e64553" #Maroon
        theme[proc_box]="#1e66f5" #Blue
        theme[div_line]="#9ca0b0"
        theme[temp_start]="#40a02b"
        theme[temp_mid]="#df8e1d"
        theme[temp_end]="#d20f39"
        theme[cpu_start]="#179299"
        theme[cpu_mid]="#209fb5"
        theme[cpu_end]="#7287fd"
        theme[free_start]="#8839ef"
        theme[free_mid]="#7287fd"
        theme[free_end]="#1e66f5"
        theme[cached_start]="#209fb5"
        theme[cached_mid]="#1e66f5"
        theme[cached_end]="#7287fd"
        theme[available_start]="#fe640b"
        theme[available_mid]="#e64553"
        theme[available_end]="#d20f39"
        theme[used_start]="#40a02b"
        theme[used_mid]="#179299"
        theme[used_end]="#04a5e5"
        theme[download_start]="#fe640b"
        theme[download_mid]="#e64553"
        theme[download_end]="#d20f39"
        theme[upload_start]="#40a02b"
        theme[upload_mid]="#179299"
        theme[upload_end]="#04a5e5"
        theme[process_start]="#209fb5"
        theme[process_mid]="#7287fd"
        theme[process_end]="#8839ef"
      '';
      dark = ''
        theme[main_bg]="#1e1e2e"
        theme[main_fg]="#cdd6f4"
        theme[title]="#cdd6f4"
        theme[hi_fg]="#89b4fa"
        theme[selected_bg]="#45475a"
        theme[selected_fg]="#89b4fa"
        theme[inactive_fg]="#7f849c"
        theme[graph_text]="#f5e0dc"
        theme[meter_bg]="#45475a"
        theme[proc_misc]="#f5e0dc"
        theme[cpu_box]="#cba6f7" #Mauve
        theme[mem_box]="#a6e3a1" #Green
        theme[net_box]="#eba0ac" #Maroon
        theme[proc_box]="#89b4fa" #Blue
        theme[div_line]="#6c7086"
        theme[temp_start]="#a6e3a1"
        theme[temp_mid]="#f9e2af"
        theme[temp_end]="#f38ba8"
        theme[cpu_start]="#94e2d5"
        theme[cpu_mid]="#74c7ec"
        theme[cpu_end]="#b4befe"
        theme[free_start]="#cba6f7"
        theme[free_mid]="#b4befe"
        theme[free_end]="#89b4fa"
        theme[cached_start]="#74c7ec"
        theme[cached_mid]="#89b4fa"
        theme[cached_end]="#b4befe"
        theme[available_start]="#fab387"
        theme[available_mid]="#eba0ac"
        theme[available_end]="#f38ba8"
        theme[used_start]="#a6e3a1"
        theme[used_mid]="#94e2d5"
        theme[used_end]="#89dceb"
        theme[download_start]="#fab387"
        theme[download_mid]="#eba0ac"
        theme[download_end]="#f38ba8"
        theme[upload_start]="#a6e3a1"
        theme[upload_mid]="#94e2d5"
        theme[upload_end]="#89dceb"
        theme[process_start]="#74c7ec"
        theme[process_mid]="#b4befe"
        theme[process_end]="#cba6f7"
      '';
    };
  };
}
