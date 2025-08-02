function nvimp
  set query $argv[1]
  set plguins_root ~/.local/share/nvim/site/pack/core/opt
  set plugin_path (ls $plguins_root | fzf -1 -q "$query")

  if test $status -eq 0
    # sudo rm -rf "$plguins_root/$plugin_path"
    cd "$plguins_root/$plugin_path"
    nvims
  end
end
