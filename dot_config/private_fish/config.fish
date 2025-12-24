if status is-interactive
    set fish_greeting

    # path
    fish_add_path ~/.local/bin

    # envvars
    set -gx EDITOR hx
    set -gx MISE_IGNORED_CONFIG_PATHS "~/.local/share/chezmoi"
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket"

    # sources
    test -d /home/linuxbrew/.linuxbrew && /home/linuxbrew/.linuxbrew/bin/brew shellenv | source
    command -vq mise && mise activate fish | source
    command -vq starship && starship init fish | source
    command -vq zoxide && zoxide init fish | source

    # functions
    function mkcd
        mkdir -pv $argv && cd $argv
    end
    function cheat
        curl cht.sh/$argv
    end

    # abbrs
    command -vq eza && abbr --add ls eza
    abbr --add rt trash put
    abbr --add lg lazygit
    abbr --add flatpakk flatpak --user
    abbr --add dotfiles cd ~/.local/share/chezmoi
end
