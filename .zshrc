# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# History
if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
HISTSIZE=20000
SAVEHIST=10000
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# completion
autoload -U compinit
compinit
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group yes
zstyle ':completion:*:options' description yes
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|?=**'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
zmodload zsh/complist

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

# keybindings
bindkey -e
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[3;5~' kill-word
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey ${terminfo[kpp]} up-line-or-history
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey ${terminfo[knp]} down-line-or-history
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey ${terminfo[kcbt]} reverse-menu-complete
bindkey ' ' magic-space
bindkey "^[m" copy-prev-shell-word
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# Misc Configuration
setopt INTERACTIVE_COMMENTS
export EDITOR="nvim"
export TERMINAL="alacritty"
export PAGER="less"
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CD_SILENT
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

# Some alias and function
alias zr='exec zsh' # restart zsh
alias j='jump' # alias for zshmarks
alias gist='gh gist'
alias exip='curl -s icanhazip.com'
alias loip='ip -brief -color address'
function mkcd() {
  mkdir -p ${1} && cd ${1}
}
function ex() {
  if [ -f $1 ]; then
    case ${1} in
      *.tar) tar -xf $1 ;;
      *.tar.bz|*.tar.bz2|*.tbz|*.tbz2) tar -xjf $1 ;;
      *.tar.gz|*.tgz) tar -xzf $1 ;;
      *.tar.lzma|*.tlz) tar -xf $1 ;;
      *.tar.xz|*.txz) tar -xJf $1 ;;
      *.tar.zst|*.tzst) tar --use-compress-program=unzstd -xvf $1 ;;
      *.bz|*.bz2) bunzip2 $1 ;;
      *.gz) gunzip $1 ;;
      *.lzma) unlzma -T0 $1 ;;
      *.xz) unxz -T0 $1 ;;
      *.zst) zstd -T0 -d $1 ;;
      *.zip) unzip $1;;
      *.rar) unrar x -ad $1 ;;
      *.7z) 7z x $1 ;;
      *.Z) uncompress $1 ;;
      *) echo "'$1' cannot be extracted via ex" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

if (( ${+commands[exa]} )); then
  alias ls='exa --group-directories-first --icons'
  alias l='ls -l --git'
  alias la='l -a'
  alias ltree='l -T'
  alias lx='l -s extension'
  alias lk='l -s size'
  alias lm='l -s modified'
  alias lc='l -s accessed'
else
  alias ls='ls --group-directories-first --color'
  alias l='ls -lh'
  alias lk='l -Sr'
  alias lm='l -tr'
fi

if (( ${+commands[aria2c]} )); then
  alias get='aria2c --max-connection-per-server=5 --continue'
elif (( ${+commands[axel]} )); then
  alias get='axel --num-connections=5 --alternate'
elif (( ${+commands[wget]} )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

if (( ${+commands[nala]} )); then
  alias apt='sudo nala'
fi

# plugin locations
ZPLUGINDIR=${ZPLUGINDIR:-${ZDOTDIR:-$HOME/.config/zsh}/plugins}

# clone a plugin, identify its init file, source it, and add it to your fpath
function plug-load {
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
function plug-up {
  for d in $ZPLUGINDIR/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
  exec zsh
}

# plugin compile function
function plug-compile {
  autoload -U zrecompile
  local f
  for f in $ZPLUGINDIR/**/*.zsh{,-theme}(N); do
    zrecompile -pq "$f"
  done
}

# plugin listing function
function plug-list {
  ls $ZPLUGINDIR
}

function plug-rm {
  rm -rf $ZPLUGINDIR/$1
}

plug=(
  romkatv/powerlevel10k
  romkatv/zsh-defer
  skywind3000/z.lua
  peterhurford/up.zsh
  jocelynmallon/zshmarks
  hlissner/zsh-autopair
  hcgraf/zsh-sudo
  zsh-users/zsh-completions
  # z-shell/zsh-diff-so-fancy
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-history-substring-search
  zsh-users/zsh-autosuggestions
)

plug-load ${plug}

# path
# path+=('$HOME/.local/bin')
# path+=('${HOME}/.spicetify')
# export PATH
export "PATH=$HOME/.spicetify:$PATH"

# asdf
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim:et sts=2 sw=2 ft=zsh
