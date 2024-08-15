#!/bin/bash
echo " ============================== "
echo " = Setting up Shell Aliases   = "
echo " ============================== "


shellRC=""
function FindShell () {
	#
	# Find shell
	userShell="$(echo $SHELL|rev|cut -d'/' -f 1|rev)"

	if [[ "$userShell" == "zsh" ]]; then
		shellRC=".zshrc"
	elif [[ "$userShell" == "bash" ]]; then
		shellRC=".bashrc"
	fi
	
	echo "$userShell found! - $shellRC"
}

aliases=(	'alias ll="ls -alkh"',\ 
		'alias deldir="rm -rf"',\
		"alias git-add-commit=\"git config --global alias.add-commit '!git add -A && git commit' \"" ,\
		'alias ff="fzf --preview \"bat --color=always {}\""'
	)

FindShell

for i in "${aliases[@]}"; do
	echo "$i" >> ~/$shellRC
done


