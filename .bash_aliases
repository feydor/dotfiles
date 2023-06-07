## .bash_aliases
alias python='python3'
# nvim is vim
alias vim='nvim'
# trash instead of delete
alias tt='gio trash'
# Ask for confirmation before deleting
alias rm='rm -i'

# diff in color
# -y side-by-side
# -B ignore blank lines
# -Z ignore trailing whitespace
alias diffc='diff --color=always -y -B -Z'

# Range-checked std::vector
alias g++='g++-12 -Wextra -pedantic -Wall -g --std=c++20 -D_GLIBCXX_CONCEPT_CHECKS -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC'

# Custom dotfiles related git aliases
alias dotfiles='/usr/bin/git --git-dir=/home/fffere/.dotfiles/ --work-tree=/home/fffere'
alias config='/usr/bin/git --git-dir=/home/fffere/.dotfiles/ --work-tree=/home/fffere'

