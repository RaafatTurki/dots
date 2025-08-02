// export let data = #{
//   for_vcs: LOCAL,
//   cool_setting: if SYSTEM.hostname == "foo" { 10 } else { 25 }
// };

export let eggs = #{
  bin: #{
    targets: "~/.local/bin",
  },

  home: #{
    targets: #{
      // ".bashrc": "~/.bashrc",
      ".xprofile": "~/.xprofile",
      ".profile": "~/.profile",
    }
  },

  wallpapers: #{
    targets: "~/.config/wallpapers",
    strategy: "merge",
  },

  alacritty: #{
    targets: "~/.config/alacritty",
    enabled: false,
  },

  fish: #{
    targets: "~/.config/fish",
  },

  git: #{
    targets: "~/.config/git",
  },

  gitui: #{
    targets: "~/.config/gitui",
  },

  gtk: #{
    targets: #{
      "gtk-2.0": "~/.config/gtk-2.0",
      "gtk-3.0": "~/.config/gtk-3.0",
      "gtk-4.0": "~/.config/gtk-4.0",
    },
  },

  herbstluftwm: #{
    targets: "~/.config/herbstluftwm",
  },

  htop: #{
    targets: "~/.config/htop",
  },

  mpv: #{
    targets: "~/.config/mpv",
  },

  nano: #{
    targets: "~/.config/nano",
  },

  neofetch: #{
    enabled: false,
    targets: "~/.config/neofetch",
  },

  fastfetch: #{
    targets: "~/.config/fastfetch",
  },

  pacman: #{
    targets: "~/.config/pacman",
  },

  parcellite: #{
    targets: "~/.config/parcellite",
  },

  paru: #{
    targets: "~/.config/paru",
  },

  picom: #{
    targets: "~/.config/picom",
  },

  pipewire: #{
    targets: "~/.config/pipewire",
  },

  qt: #{
    targets: #{
      "qt5ct": "~/.config/qt5ct",
      "qt6ct": "~/.config/qt6ct",
    },
  },

  readline: #{
    targets: "~/.config/readline",
  },

  rofi: #{
    targets: "~/.config/rofi",
  },

  screenkey: #{
    targets: #{
      "screenkey.json": "~/.config/screenkey.json",
    }
  },

  slop: #{
    targets: "~/.config/slop",
  },

  systemd: #{
    targets: "~/.config/systemd",
  },

  thunar: #{
    targets: "~/.config/Thunar",
  },

  tmux: #{
    targets: "~/.config/tmux",
  },

  x11: #{
    targets: "~/.config/x11",
  },

  bruno: #{
    targets: #{
      "preferences.json": "~/.config/bruno/preferences.json",
    }
  },

  dunst: #{
    targets: "~/.config/dunst",
  },

  lazybar: #{
    targets: "~/.config/lazybar",
  },

  xsettingsd: #{
    targets: "~/.config/xsettingsd",
  },

  quickshell: #{
    targets: "~/.config/quickshell",
  },

  network_manager: #{
    targets: "~/.config/network_manager",
  },

  fonts: #{
    targets: "~/.local/share/fonts",
  },

  userdirs: #{
    strategy: "merge",
    targets: #{
      "user-dirs.dirs": "~/.config/user-dirs.dirs",
    }
  },

  mimeappslist: #{
    strategy: "merge",
    targets: #{
      "mimeapps.list": "~/.config/mimeapps.list",
    }
  },



  shortsig: #{
    enabled: false,
    targets: "~/.config/shortsig",
  },
  polybar: #{
    enabled: false,
    targets: "~/.config/polybar",
  },
  wol: #{
    enabled: false,
    targets: "~/.config/wol",
  },
};
