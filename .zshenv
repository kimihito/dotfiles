if [[ "$OSTYPE" == "linux-gnu" ]]; then
  keychain --nogui --quiet ~/.ssh/github_rsa
  source ~/.keychain/$HOST-sh
fi
