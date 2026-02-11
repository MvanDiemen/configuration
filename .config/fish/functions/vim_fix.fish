function vim_fix
  rm -rf .elixir_ls
  mix deps.get
  env MIX_ENV=test mix compile
end
