function grmb
  git branch | fzf -m | xargs -n1 -I {} git branch -D {}
end

