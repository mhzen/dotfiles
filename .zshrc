# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# vim-y stuff
EDITOR=nvim
bindkey -v

# history
if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
HISTSIZE=20000
SAVEHIST=10000
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY

# misc
setopt INTERACTIVE_COMMENTS

# completion
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# keybindings
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[3;5~' kill-word
bindkey ${terminfo[kpp]} up-line-or-history
bindkey ${terminfo[knp]} down-line-or-history
bindkey ${terminfo[kcbt]} reverse-menu-complete
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# plugin locations
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# clone a plugin, identify its init file, source it, and add it to your fpath
function plugin-load {
  local repo plugin_name plugin_dir initfile initfiles
  for repo in $@; do
    plugin_name=${repo:t}
    plugin_dir=$ZPLUGINDIR/$plugin_name
    initfile=$plugin_dir/$plugin_name.plugin.zsh
    if [[ ! -d $plugin_dir ]]; then
      echo "Cloning $repo"
      git clone -q --depth 1 --recursive --shallow-submodules https://github.com/$repo $plugin_dir
    fi
    if [[ ! -e $initfile ]]; then
      initfiles=($plugin_dir/*.plugin.{z,}sh(N) $plugin_dir/*.{z,}sh{-theme,}(N))
      [[ ${#initfiles[@]} -gt 0 ]] || { echo >&2 "Plugin has no init file '$repo'." && continue }
      ln -sf "${initfiles[1]}" "$initfile"
    fi
    fpath+=$plugin_dir
    (( $+functions[zsh-defer] )) && zsh-defer . $initfile || . $initfile
  done
}

# plugin update function
function plugin-update {
  ZPLUGINDIR=${ZPLUGINDIR:-$HOME/.config/zsh/plugins}
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

plug=(
    romkatv/powerlevel10k
    skywind3000/z.lua
    peterhurford/up.zsh
    zsh-users/zsh-completions
    zdharma-continuum/fast-syntax-highlighting
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions
)

plugin-load $plug

# aliases
alias zshcfg="vim ~/.zshrc"
alias zshres="exec zsh"
if (( ${+commands[aria2c]} )); then
  alias get='aria2c --max-connection-per-server=5 --continue'
elif (( ${+commands[axel]} )); then
  alias get='axel --num-connections=5 --alternate'
elif (( ${+commands[wget]} )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

# colors
if (( terminfo[colors] >= 8 )); then
  # grep colours
  if (( ! ${+GREP_COLOR} )) export GREP_COLOR='37;45'               #BSD
  if (( ! ${+GREP_COLORS} )) export GREP_COLORS="mt=${GREP_COLOR}"  #GNU
  if [[ ${OSTYPE} == openbsd* ]]; then
    if (( ${+commands[ggrep]} )) alias grep='ggrep --color=auto'
  else
    alias grep='grep --color=auto'
  fi

  # less colours
  if (( ${+commands[less]} )); then
    if (( ! ${+LESS_TERMCAP_mb} )) export LESS_TERMCAP_mb=$'\E[1;31m'   # Begins blinking.
    if (( ! ${+LESS_TERMCAP_md} )) export LESS_TERMCAP_md=$'\E[1;31m'   # Begins bold.
    if (( ! ${+LESS_TERMCAP_me} )) export LESS_TERMCAP_me=$'\E[0m'      # Ends mode.
    if (( ! ${+LESS_TERMCAP_se} )) export LESS_TERMCAP_se=$'\E[27m'     # Ends standout-mode.
    if (( ! ${+LESS_TERMCAP_so} )) export LESS_TERMCAP_so=$'\E[7m'      # Begins standout-mode.
    if (( ! ${+LESS_TERMCAP_ue} )) export LESS_TERMCAP_ue=$'\E[0m'      # Ends underline.
    if (( ! ${+LESS_TERMCAP_us} )) export LESS_TERMCAP_us=$'\E[1;32m'   # Begins underline.
  fi
else
  # See https://no-color.org
  export NO_COLOR=1
fi

# path
path+=('~/.local/bin')
export PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
