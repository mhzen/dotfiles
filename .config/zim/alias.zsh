alias zr='z -r'
alias zt='z -t'
alias zi='z -I'
alias zshrc="$EDITOR ~/.zshrc"
alias aliasrc="$EDITOR $ZIM_HOME/alias.zsh"
alias e="$EDITOR"
alias j='jump'
alias gist='gh gist'
alias exip='curl -s icanhazip.com'
alias loip='ip -brief -color address'
alias rzsh="exec zsh"
alias cp="cp -i"
alias mv="mv -i"
alias todo="todo.sh"
alias copy="xclip-copyfile"
alias paste="xclip-pastefile"
alias cut="xclip-cutfile"
alias :q="exit"

function mkcd() {
  mkdir -p ${1} && cd ${1}
}

# taken from https://github.com/peterhurford/up.zsh
function up(){
  if [[ "$#" -ne 1 ]]; then
    cd ..
  elif ! [[ $1 =~ '^[0-9]+$' ]]; then
    echo "Error: up should be called with the number of directories to go up. The default is 1."
  else
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
      do
        d=$d/..
      done
    d=$(echo $d | sed 's/^\///')
    cd $d
  fi
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

if (( ${+commands[trash-put]} )); then
  alias rm='trash-put'
else
  alias rm='rm -i'
fi

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

__sudo-replace-buffer() {
  local old=$1 new=$2 space=${2:+ }

  # if the cursor is positioned in the $old part of the text, make
  # the substitution and leave the cursor after the $new text
  if [[ $CURSOR -le ${#old} ]]; then
    BUFFER="${new}${space}${BUFFER#$old }"
    CURSOR=${#new}
  # otherwise just replace $old with $new in the text before the cursor
  else
    LBUFFER="${new}${space}${LBUFFER#$old }"
  fi
}

function sudo-command-line() {
  # If line is empty, get the last run command from history
  [[ -z $BUFFER ]] && LBUFFER="$(fc -ln -1)"

  # Save beginning space
  local WHITESPACE=""
  if [[ ${LBUFFER:0:1} = " " ]]; then
    WHITESPACE=" "
    LBUFFER="${LBUFFER:1}"
  fi

  {
    # If $SUDO_EDITOR or $VISUAL are defined, then use that as $EDITOR
    # Else use the default $EDITOR
    local EDITOR=${SUDO_EDITOR:-${VISUAL:-$EDITOR}}

    # If $EDITOR is not set, just toggle the sudo prefix on and off
    if [[ -z "$EDITOR" ]]; then
      case "$BUFFER" in
        sudo\ -e\ *) __sudo-replace-buffer "sudo -e" "" ;;
        sudo\ *) __sudo-replace-buffer "sudo" "" ;;
        *) LBUFFER="sudo $LBUFFER" ;;
      esac
      return
    fi

    # Check if the typed command is really an alias to $EDITOR

    # Get the first part of the typed command
    local cmd="${${(Az)BUFFER}[1]}"
    # Get the first part of the alias of the same name as $cmd, or $cmd if no alias matches
    local realcmd="${${(Az)aliases[$cmd]}[1]:-$cmd}"
    # Get the first part of the $EDITOR command ($EDITOR may have arguments after it)
    local editorcmd="${${(Az)EDITOR}[1]}"

    # Note: ${var:c} makes a $PATH search and expands $var to the full path
    # The if condition is met when:
    # - $realcmd is '$EDITOR'
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "cmd --with --arguments"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "cmd"
    # - $realcmd is "/path/to/cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is "cmd"
    # - $realcmd is "cmd" and $EDITOR is "/path/to/cmd"
    # or
    # - $realcmd is "cmd" and $EDITOR is /alternative/path/to/cmd that appears in $PATH
    if [[ "$realcmd" = (\$EDITOR|$editorcmd|${editorcmd:c}) \
      || "${realcmd:c}" = ($editorcmd|${editorcmd:c}) ]] \
      || builtin which -a "$realcmd" | command grep -Fx -q "$editorcmd"; then
      __sudo-replace-buffer "$cmd" "sudo -e"
      return
    fi

    # Check for editor commands in the typed command and replace accordingly
    case "$BUFFER" in
      $editorcmd\ *) __sudo-replace-buffer "$editorcmd" "sudo -e" ;;
      \$EDITOR\ *) __sudo-replace-buffer '$EDITOR' "sudo -e" ;;
      sudo\ -e\ *) __sudo-replace-buffer "sudo -e" "$EDITOR" ;;
      sudo\ *) __sudo-replace-buffer "sudo" "" ;;
      *) LBUFFER="sudo $LBUFFER" ;;
    esac
  } always {
    # Preserve beginning space
    LBUFFER="${WHITESPACE}${LBUFFER}"

    # Redisplay edit buffer (compatibility with zsh-syntax-highlighting)
    zle redisplay
  }
}

zle -N sudo-command-line

# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line
bindkey -M viins '\e\e' sudo-command-line
