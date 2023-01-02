# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR="nvim"
export TERMINAL="alacritty"
export GPG_TTY=$(tty)
path+=(~/.local/bin)
export PATH
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export NNN_PLUG='f:finder;p:mocplay;d:diffs;t:nmount;v:imgview'

bindkey -e
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER
setopt NO_CASE_GLOB
setopt NO_LIST_BEEP
setopt EXTENDED_GLOB
if (( ! ${+HISTFILE} )) typeset -g HISTFILE=${ZDOTDIR:-${HOME}}/.zhistory
HISTSIZE=20000
SAVEHIST=10000

# alias
alias :q='exit'
alias open='xdg-open'
if (( $+commands[exa] )); then
  alias ls='exa --group-directories-first'
else
  alias ls='ls --group-directories-first --color=auto'
fi
alias l='ls -lh --git'
alias ll='l -a'
(( $+commands[trash-put] )) && alias rm='trash-put'
function mkcd() {
  mkdir -p $@ && cd ${@:$#}
}

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d $ZINIT_HOME ]]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"


zinit lucid light-mode nocd for \
    romkatv/powerlevel10k \
    OMZL::termsupport.zsh

zinit wait lucid light-mode for \
    OMZL::{completion,key-bindings}.zsh \
    OMZP::{sudo,fzf} \
  atclone"lua z.lua --init zsh enhanced once > z.zsh" \
  atpull"%atclone" pick"z.zsh" nocompile"!" \
  atload"alias zz='z -I'; alias zb='z -b'; alias zc='z -c'; alias zzc='zz -c'" \
    skywind3000/z.lua \
  atclone"dircolors -b LS_COLORS > clrs.zsh" \
  atpull'%atclone' pick"clrs.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
    trapd00r/LS_COLORS \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
    zsh-users/zsh-completions

[[ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]] && \
. /usr/share/nnn/quitcd/quitcd.bash_zsh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
