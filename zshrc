# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="muse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting zsh-autosuggestions compleat)

source $ZSH/oh-my-zsh.sh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=98'
setopt HIST_IGNORE_SPACE
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

gitdir="$HOME/github/yhren"
#pandoc="/usr/local/bin/pandoc"
pandoc="$HOME/anaconda3/bin/pandoc"

# export PS1='\[\033[1;34m\]\h$\[\033[0m\]'

## OS dependent
if [ "$(uname 2>/dev/null)" = "Darwin" ]; then
	alias o=" open"
    alias u=" brew update"
elif [ "$(uname 2>/dev/null)" = "Linux" ]; then
	alias o=" xdg-open"
	alias u=" yes | sudo apt update &&\
		yes | sudo apt upgrade &&\
		yes | sudo apt autoremove"
	alias pbcopy='xclip -selection clipboard'
	alias pbpaste='xclip -selection clipboard -o'
else

fi

#  shorthand for submiting an exercise using exercism
#  learn more about exercism: exercism.io/
# important to use "command exercism" so the function does
# not call itself recursively.

alias l="ls -lthsrG"
alias h="history"
alias g="grep"
alias v="nvim -O"
alias vd="nvim -d"
alias t="task"
alias tm="$HOME/.local/bin/tm.sh"
alias m="make"
alias bc="bc -q"
alias cs="cht.sh"
alias crt="cp $gitdir/CppMacros/macros.h ./main.cpp; cp $gitdir/CppMacros/Makefile .; cp $gitdir/CppMacros/.vimspector.json .;"
alias dotfile='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
alias vulcan="ssh -N -L 8888:localhost:8888 -L 6006:localhost:6006 vulcan"
alias bnl="ssh -N -C -D 5150 bnl"
alias pylab="jupyter lab"
alias pip='noglob pip'
alias w3m="w3m -sixel -o display_image=1"
export W3M_IMG2SIXEL="/usr/local/bin/img2sixel"
alias es="$HOME/.local/bin/es.sh"

function exercism {
    case "$1" in
        download) __exercism_download "$@" ;;
        submit) es ;;
        *) command exercism "$@" ;;
    esac
}

function __exercism_download {
    out=($(command exercism "$@"))
    [[ -d "${out[-1]}" ]] && cd "${out[-1]}" || echo "cd fails" >&2
}
md2pdf () { fname=$1; echo $fname;
	$pandoc "$1" \
		-V geometry:margin=1in \
		-s --pdf-engine=xelatex \
		--variable urlcolor=cyan \
		-o ${fname%.md}.pdf; }

md2html () { fname=$1; echo $fname;
	$pandoc "$1" \
		-V geometry:margin=1in \
		--variable urlcolor=cyan \
		-o ${fname%.md}.html; }

tunnel () {
	if [[ $# < 1 ]]; then
		echo "specific a hostname";
	elif [[ $# < 2 ]]; then
		echo "setup ssh tunneling to <$1> using port [9999]"
		ssh -N -L 9999:localhost:9999 $1
	elif [[ $# < 3 ]]; then
		echo "setup ssh tunneling to <$1> using port [$2]"
		ssh -N -L ${2}:localhost:${2} $1
	else:
		echo " too many arguments "
	fi; }

if command -v nvim > /dev/null 2>&1;
then
	export VISUAL=nvim
else
	export VISUAL=vim
fi

export TERM=xterm-256color
# conda env

if [[ -d $HOME/.fonts ]] && ls $HOME/.fonts/*.sh 1> /dev/null 2>&1;
then  
    source ~/.fonts/*.sh
fi


# per host setting
_hostname=$(hostname)
if [[ "$_hostname" == "LCC-165284.local" ]]; then
    __conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/yren/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/Users/yren/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
# export PATH="/Users/yren/anaconda3/bin:$PATH"  # commented out by conda initialize
        fi
    fi
    unset __conda_setup
    export PATH="$HOME/.local/bin:$PATH"
elif [[ "$_hostname" == "ryzen" ]]; then
        __conda_setup="$('/home/yren/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/yren/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/home/yren/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
# export PATH="/home/yren/anaconda3/bin:$PATH"  # commented out by conda initialize
        fi
    fi
    unset __conda_setup
    export PATH="/usr/local/cuda/bin:$PATH"
    export PATH="$PATH:$HOME/julialang/bin"
    export PATH=$PATH:/usr/local/go/bin
    export PATH="$PATH:$(go env GOPATH)/bin"
    export PATH="$(yarn global bin):$PATH"
    eval $(thefuck --alias) # fuck
    alias hid_link='sudo ~/.local/bin/hid_link'
    export PATH="$HOME/Applications/adb:$PATH"
    export PATH="$HOME/Applications/Elm:$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"
    alias vncmac="x0vncserver -localhost -rfbport 5900 -rfbauth ~/.vnc/passwd"
    alias backup="rsync -avzh $HOME/Documents/ /media/yren/ssd500G/"
elif [[ "$_hostname" == "rz21" || "$_hostname" == "thrip" ]]; then
    export PATH="$PATH:/usr/local/go/bin"
    export PATH="$(yarn global bin):$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="$HOME/.local/share/zotero/Zotero_linux-x86_64/:$PATH"
    export PATH="$HOME/.local/share/nvim/lsp_servers/pyright/node_modules/.bin:$PATH"
    export PATH="$HOME/.local/share/nvim/lsp_servers/clangd/clangd/bin:$PATH"
    export PATH="$HOME/.local/share/nvim/lsp_servers/marksman:$PATH"
    export PATH="$HOME/.local/share/nvim/lsp_servers/yamlls/node_modules/yaml-language-server/bin:$PATH"
# ~/.local/share/nvim/lsp_servers/clangd 
fi

if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning a new agent. "
        eval `ssh-agent | tee ~/.ssh/agent.env`
        ssh-add
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.ssh/agent.env`
    ssh-add
fi

## some app env 
# export TASKRC="~/.config/tasks/.taskrc"
# export TIMEWARRIORDB="~/.config/syncdata/timew/"
# export TZ_LIST="Europe/Paris,US/Central,US/Pacific,Asia/Shanghai"

# test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

autoload -Uz bashcompinit && bashcompinit

# alias luamake=/home/yren/github/tools/lua-language-server/3rd/luamake/luamake

eval "$(/home/yren/anaconda3/bin/conda shell.zsh hook)" 
