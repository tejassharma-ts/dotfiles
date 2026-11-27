# Pick which GitHub account git uses in the current shell session.
#
#   git-account           choose with fzf
#   git-account work      switch directly (personal | work)
#   git-account off       back to the defaults from ~/.gitconfig
#   git-account status    show what's active and which GitHub user SSH logs in as
#
# Works by exporting env vars, which take priority over ~/.gitconfig
# (including the includeIf for ~/code/work) and over ~/.ssh/config.

typeset -gA _GIT_ACCOUNTS
_GIT_ACCOUNTS=(
  personal "tejassharma-ts|you@personal.example|$HOME/.ssh/id_rsa_personal"
  work     "TEJAS|you@work.example|$HOME/.ssh/id_ed25519"
)

git-account() {
  local choice=$1
  if [[ -z $choice ]]; then
    choice=$(printf '%s\n' ${(ok)_GIT_ACCOUNTS} off |
      fzf --prompt='git account> ' --height=~10 --reverse) || return 1
  fi

  case $choice in
    status)
      echo "account: ${GIT_ACCOUNT:-default (from ~/.gitconfig)}"
      echo "commits: $(git var GIT_AUTHOR_IDENT | sed 's/ [0-9]* [+-][0-9]*$//')"
      echo "github:  $(${=GIT_SSH_COMMAND:-ssh} -o BatchMode=yes -o ConnectTimeout=8 -T git@github.com 2>&1 |
        sed -n 's/^Hi \([^!]*\)!.*/\1/p')"
      return
      ;;
    off)
      unset GIT_ACCOUNT GIT_SSH_COMMAND \
        GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
      echo "git account: default (from ~/.gitconfig)"
      return
      ;;
  esac

  local entry=${_GIT_ACCOUNTS[$choice]}
  if [[ -z $entry ]]; then
    echo "unknown account '$choice' (use: ${(ok)_GIT_ACCOUNTS} off status)" >&2
    return 1
  fi

  local name email key
  IFS='|' read -r name email key <<< "$entry"
  export GIT_ACCOUNT=$choice
  export GIT_AUTHOR_NAME=$name GIT_COMMITTER_NAME=$name
  export GIT_AUTHOR_EMAIL=$email GIT_COMMITTER_EMAIL=$email
  # ~/.ssh/config pins github.com to the work key, and ssh tries config keys
  # before -i, so give git's ssh its own config for github hosts instead.
  # IdentitiesOnly stops ssh-agent from offering the other account's key.
  local ssh_conf=${XDG_RUNTIME_DIR:-/tmp}/git-account-$choice.ssh
  cat > $ssh_conf <<EOF
Host github.com github.com-personal
  HostName github.com
  User git
  IdentityFile $key
  IdentitiesOnly yes
EOF
  export GIT_SSH_COMMAND="ssh -F $ssh_conf"
  echo "git account: $choice ($name <$email>)"
}

_git-account() { _values 'account' ${(k)_GIT_ACCOUNTS} off status }
compdef _git-account git-account

# for PROMPT: shows e.g. [work] while an account is selected
git_account_prompt_info() {
  [[ -n $GIT_ACCOUNT ]] && echo "%{$fg[yellow]%}[$GIT_ACCOUNT]%{$reset_color%} "
}
