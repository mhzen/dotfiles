if status is-interactive
    set fish_greeting

    # abbrs
    command -vq eza && abbr --add ls eza
    abbr --add rt trash put
    abbr --add lg lazygit

    # functions
    function mkcd
        mkdir -pv $argv && cd $argv
    end
    function cheat
        curl cht.sh/$argv
    end

    # envvars
    set -gx EDITOR hx

    # sources
    command -vq starship && starship init fish | source
    command -vq zoxide && zoxide init fish | source
    command -vq mise && mise activate fish | source
    command -vq atuin && atuin init fish | source

    # path
    fish_add_path ~/.local/share/soar/bin
end
