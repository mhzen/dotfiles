<div align=center>

# .*

</div>

# Usage
```
chezmoi init --apply git@github.com:mhzen/dotfiles.git # just apply
//
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply git@github.com:mhzen/dotfiles.git # bootstrap
```

# Tree
```
.
├── dot_config
│   ├── Brewfile
│   ├── ghostty
│   │   └── config
│   ├── git
│   │   └── config.tmpl
│   ├── helix
│   │   └── config.toml
│   ├── mise
│   │   └── config.toml
│   ├── nvim
│   │   ├── dot_gitignore
│   │   ├── dot_neoconf.json
│   │   ├── init.lua
│   │   ├── lazy-lock.json
│   │   ├── lazyvim.json
│   │   ├── lua
│   │   │   ├── config
│   │   │   │   ├── autocmds.lua
│   │   │   │   ├── keymaps.lua
│   │   │   │   ├── lazy.lua
│   │   │   │   └── options.lua
│   │   │   └── plugins
│   │   │       └── theme.lua
│   │   └── stylua.toml
│   ├── paru
│   │   └── paru.conf
│   ├── private_albert
│   │   └── config
│   ├── private_Code
│   │   └── User
│   │       └── settings.json
│   ├── private_fish
│   │   └── config.fish
│   ├── private_mpv
│   │   └── mpv.conf
│   ├── redshift
│   │   └── redshift.conf.tmpl
│   ├── scripts
│   │   ├── gnome-keybindings.sh
│   │   └── manifest.txt
│   ├── wezterm
│   │   └── wezterm.lua
│   └── xfce4
│       └── xfconf
│           └── private_xfce-perchannel-xml
│               └── xfce4-keyboard-shortcuts.xml
└── README.md
```
