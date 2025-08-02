function git_convert_to_ssh
	set repo_name (basename $PWD)
    # set repo_author 

	git remote set-url origin git@github.com:RaafatTurki/$argv[1].git
	# git remote set-url origin git@github.com:gr-vii/$argv[1].git

	# git remote set-url origin git@github.com:RaafatTurki/$repo_name.git
	# git push --set-upstream <remote-name> <branch-name>
end
