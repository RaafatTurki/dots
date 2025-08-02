function nvimprm
  set query $argv[1]
  set plguins_root ~/.local/share/nvim/lazy
  set plugin_path (ls $plguins_root | fzf -1 -q "$query")

  if test $status -eq 0
    sudo rm -rf "$plguins_root/$plugin_path"
  end
end
