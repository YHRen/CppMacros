# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="pygmalion"

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
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=98'

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
pandoc="/usr/local/bin/pandoc"

export PS1='\[\033[1;34m\]\h$\[\033[0m\]'

if [ "$(uname 2>/dev/null)" = "Darwin" ]; then
	alias o="open"
    alias u="brew update"
elif [ "$(uname 2>/dev/null)" = "Linux" ]; then
	alias o="xdg-open"
	alias u="yes | sudo apt update &&\
		yes | sudo apt upgrade &&\
		yes | sudo apt autoremove"
	alias pbcopy='xclip -selection clipboard'
	alias pbpaste='xclip -selection clipboard -o'
else

fi

alias l="ls -lthsrG"
alias h="history"
alias g="grep"
alias v="nvim"
alias m="make"
alias bc="bc -q"
alias crt="cp $gitdir/CppMacros/macros.h ./main.cpp; cp $gitdir/CppMacros/Makefile ."
alias vulcan="ssh -C -D 5150 vulcan"
alias pylab="jupyter lab"

md2pdf () { fname=$1; echo $fname;
	$pandoc "$1" \
		-V geometry:margin=1in \
		-s --pdf-engine=xelatex \
		--variable urlcolor=cyan \
		-F mermaid-filter \
		-o ${fname%.md}.pdf; }

md2html () { fname=$1; echo $fname;
	$pandoc "$1" \
		-V geometry:margin=1in \
		--variable urlcolor=cyan \
		-F mermaid-filter \
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
source .bash_profile
