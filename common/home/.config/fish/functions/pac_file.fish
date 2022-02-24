function pac_file
  # setting pacman command
  # set pm_cmd paru
  set pm_cmd $AUR_HELPER

  set pkg ($pm_cmd -Qsq | fzf)
  set files (paru -Ql $pkg | cut -d ' ' -f 2)
  set file (printf %s\n $files | fzf)

  echo $file
end
