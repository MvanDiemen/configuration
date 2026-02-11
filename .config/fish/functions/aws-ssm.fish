function aws-ssm
  aws ssm start-session --target $argv --profile=production
end
