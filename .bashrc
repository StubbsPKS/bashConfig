# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Source work-only aliases
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi



JAVA_HOME=/usr/lib/jvm/jre-1.6.0-openjdk.x86_64
PATH=$PATH:/usr/lib/jvm/jre-1.6.0-openjdk.x86_64/bin

## COLORS  Used for the prompt.
#Regular text color
BLACK='\e[0;30m'
#Bold text color
BBLACK='\e[1;30m'
#background color
BGBLACK='\e[40m'
RED='\e[0;31m'
BRED='\e[1;31m'
BGRED='\e[41m'
GREEN='\e[0;32m'
BGREEN='\e[1;32m'
BGGREEN='\e[1;32m'
YELLOW='\e[0;33m'
BYELLOW='\e[1;33m'
BGYELLOW='\e[1;33m'
BLUE='\e[0;34m'
BBLUE='\e[1;34m'
BGBLUE='\e[1;34m'
MAGENTA='\e[0;35m'
BMAGENTA='\e[1;35m'
BGMAGENTA='\e[1;35m'
CYAN='\e[0;36m'
BCYAN='\e[1;36m'
BGCYAN='\e[1;36m'
WHITE='\e[0;37m'
BWHITE='\e[1;37m'
BGWHITE='\e[1;37m'
RESET='\e[0m'

## FUNCTIONS
ec2() {
	local searchTerm=$1
	local region=$2
	
	cmdString="aws ec2 describe-instances --filters \"Name=tag:Name,Values=*${searchTerm}*\" --query \"Reservations[*].Instances[*].[PrivateIpAddress,Tags[?Key=='Name']| [0].Value]\" --output=table"
	if [[ ! -z $region ]]; then
		cmdString="$cmdString --region $region"
	fi

	#echo "Command would be: $cmdString"
	eval $cmdString
}

## ALIASES

# Grab my ip from CLI
alias myip="curl ifconfig.co"

# List only hidden files
alias l.='ls -ld .* --color=auto'

# Various permutations of ls
alias ll='ls -l --color=always'
alias lt='ls -lthr --color=auto'
alias la='ls -la --color=auto'

# Always use vim
alias vi='vim'

# Fix up which
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

# Show colors in less
alias less='less -R'

# Colorize `grep`.
export GREP_COLORS="1;33"
alias grep='grep --color=auto'

# Convenient `cd..`.
alias c="cd .."

# Never `rm` `/`.
alias rm="rm --preserve-root"

# Display Monday as first day of week in `cal`.
alias cal="cal -m"

# Defaults for bc
alias bc="bc -l"


# Open multiple files as tabs.
alias vim="vim -p"

# User Define Aliases
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
source /usr/share/git-core/contrib/completion/git-prompt.sh
# Set prompt.
# `root` has a red prompt, others a yellow one.
# If we are connected remotely, `@<hostname>` shows first.
build_ps1() {
    local promptColor="${YELLOW}"
    local host=""
    local hostColor='\e[32m'
    local timeColor='\e[35m'
    local userColor="${GREEN}"
    local lineEnd='\$'
    local SMILEY="${WHITE}:)${NORMAL}"
    local FROWNY="${RED}:(${NORMAL}"

    local lastCommandColor="if [ \$? = 0 ]; then echo \"${GREEN}\"; else echo \"${RED}\"; fi"
    [[ $UID -eq 0 ]] && userColor="$RED"; lineEnd='#';
    [[ $SSH_TTY ]] && host="@$HOSTNAME "
		echo "$timeColor\t${promptCover}-${userColor}\u${promptColor}@${hostColor}\h: ${promptColor}\w [\`${lastCommandColor}\`\\!${promptColor}]\$(declare -F __git_ps1 &> /dev/null && __git_ps1) $RESET \n${lineEnd} "
}

PS1=$(build_ps1)
PS2='\\ '
PS4='+ $LINENO: '

PROMPT_COMMAND="$(build_ps1)"

# ##Share history between sessions
#
# By appending to, and reading from, the history file after each command,
# command history will be shared between bash instances.
shopt -s histappend
export PROMPT_COMMAND="history -a; history -n"
export HISTSIZE=10000

## EXPORTS
export EDITOR="vim"
export PKG_CONFIG_PATH=/usr/share/pkgconfig/

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export http_proxy=''
export https_proxy=''
export ftp_proxy=''
export socks_proxy=''
