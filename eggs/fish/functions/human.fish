function human
  set target $argv[1]

  set tmp_path "/tmp/human"

  if not test -d "$tmp_path"
    mkdir "$tmp_path"
  end

  set random (random)
  set html_file "/tmp/human/$target-$random.html"

  man $target | man2html -title $target > $html_file

  $BROWSER $html_file
end
