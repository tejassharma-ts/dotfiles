# Extra git shortcuts on top of oh-my-zsh's git plugin (run `alias | grep git` to list all)

alias gs='git status -sb'                        # short status with branch info
alias gundo='git reset --soft HEAD~1'            # undo last commit, keep changes staged
alias gamend='git commit --amend --no-edit'      # add staged changes to last commit
alias gunstage='git restore --staged'            # unstage file(s)
alias gdiscard='git restore'                     # discard unstaged changes in file(s)
alias glast='git log -1 --stat'                  # show last commit
alias gtree='git log --graph --oneline --decorate --all'
alias gpub='git push -u origin HEAD'             # publish current branch

# gcmsg "message" already exists; this one stages everything too
gac() { git add -A && git commit -m "$*"; }
# sync current branch with main/master (fetch + rebase)
gsync() { git fetch origin && git rebase "origin/$(git_main_branch)"; }
