if status is-interactive
    set fish_greeting

    # abbrs
    abbr --add ls eza
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
    zoxide init fish | source
    mise activate fish | source
    starship init fish | source
end
