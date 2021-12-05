function fish_prompt --description 'Write out the prompt'

	# USER CWD |
	# echo -n -s "$USER " (set_color blue) (prompt_pwd) (set_color normal) " | "
	
	# CWD
	echo -n -s " " (set_color blue) (prompt_pwd) (set_color normal) (set_color red) (fish_git_prompt) " "
end
