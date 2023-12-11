#.bashrc
############# NOT SAFE WITH LY DISPLAY MANAGER ################
TTY=$(tty)
if [ -z $TMUX ]; then
	if [ $SHLVL -eq 1 ] && [[ $TTY == "/dev/tty2" ]]; then
		setfont ter-powerline-v20b.psf.gz
		tmux -u
	elif [[ $DISPLAY =~ :0.?[0-9]* ]] && [ $SHLVL -eq 2 ]; then
		tmux -u
	fi
fi

################### SHELL CONFIG ##############################
if [ $SHLVL -eq 1 ]; then
	PS1='\[[1;97m\][\u\[[5m\]@\[[25m\]\h \W]\$ \[[22;0m\]'
elif [ -n "$TMUX" ] && [ $SHLVL -eq 2 ]; then
	PS1='\[[1;97m\][\u\[[5m\]@\[[25m\]\h \W]\$ \[[22;0m\]'
else
	num=$(( 29 + $SHLVL )); if [ -n "$TMUX" ]; then num=$(( $num + 59 )); fi
	PS1='\[\033[01;$(echo $num)m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi
if [ -n "$SSH_TTY" ]; then
	pre="\[\e[1;100m\]"
	PS1="$pre$PS1"
fi
PS2='\[\e[32m\]> |\[\e[m\] '

shopt -s histappend
shopt -s checkwinsize
HISTCONTROL=ignoredups
HISTSSIZE=150
HISTFILESIZE=10000
HISTTIMEFORMAT="[32m%F [92m%T [0m	"

################## ALIAS:- PRIMARY #################################
alias ls='ls --color=auto --hyperlink'
alias grep='grep --color=auto'
alias tmux='tmux -u'

alias lynx='lynx duckduckgo.com/lite'
alias iftop='iftop -i <interface>'
alias mpvv='mpv --ytdl-format="(best[height<=360])"'
alias stmp='$HOME/.local/state/stmp/wildeyedskies'
alias yt='nohup thorium-browser --incognito --app="https://www.youtube.com" '
alias nt='brave-browser --incognito --app="https://www.netflix.com" '

################# ALIAS:- SECONDARY ################################
alias dot='/usr/bin/git --git-dir=~/dotfiles/ --work-tree=~/'
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../../..;pwd'
alias ,='show'
alias ,,='tree -al'
alias :?='vim +VimwikiIndex'
alias !='$EDITOR'
alias @='open_in_editor'
alias ??='$HOME/loonyfetch/main'

################## ACCESSIBILITY #####################################
alias internet='nmcli c up <UUID> passwd-file wifi-password'
alias bt='bluetoothctl connect <AUDIO ID>'
alias vol+='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+    && wpctl get-volume @DEFAULT_AUDIO_SINK@'
alias vol-='wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-    && wpctl get-volume @DEFAULT_AUDIO_SINK@'
alias vol0='wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle && wpctl get-volume @DEFAULT_AUDIO_SINK@'
alias bkl+='xbacklight -inc 10 && xbacklight -get'
alias bkl-='xbacklight -dec 10 && xbacklight -get'
alias minx='startx $HOME/tinywm/init'

################## CUSTOM FUNCTIONS ##################################
#tree but less cool
show(){
	local dir="$1"
	cd "$dir" && \
	ls -Al 
}

open_in_editor(){
	$* > ~/intrim && ! ~/intrim
}

ply(){
	local link=$(cat $HOME/vimwiki/musics.wiki | fzf | awk 'BEGIN{FS="|"}; {print $4}')
	cat $HOME/vimwiki/musics.wiki | grep $link | awk 'BEGIN{FS="|"}; {gsub(/[ ]+/," ",$0); print "Playing " $2 " by " $3 }' | tr "\t" " "
	mpv --loop=3 --really-quiet --ytdl-format="(best[height<=360]) "$link
}

:q(){
		cp ~/vimwiki/Repo.wiki ~/vimwiki/Repo_back
		cp ~/vimwiki/Repo.wiki ~/vimwiki/Repo_temp
		history | awk '{$1=$2=$3=""; gsub(/^[ \t]+.\[0m[ \t]+/,""); print}' | sort | uniq >> ~/vimwiki/Repo_temp
		cat ~/vimwiki/Repo_temp | sort | uniq > ~/vimwiki/Repo.wiki
		rm ~/vimwiki/Repo_temp
		[[ "$1" != "-x" ]] && exit
}

:w(){
	#local IFS='|'
	local query=$*
	grep -e $(echo $query | sed 's/ / -e /' )  ~/vimwiki/Repo.wiki | more
}
:wexe(){
	:w $* | fzf | bash 
}
############NEEDED I GUESS############################################
export EDITOR="/bin/vim"
export PATH="$PATH:$HOME/script"
alias text='setfont ter-powerline-v20b.psf.gz'
