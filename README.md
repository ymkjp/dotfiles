dotfiles
========
.bashrc, .vimrc, .gitconfg, ...etc


Support environment
========
* Debian GNU/Linux, CentOS
* Mac OSX


Dependency
========
* Git version 1.8 or newer
* Add PATH git/contrib/diff-highlight/diff-highlight


Local settings
===
* You can add local settings depends on your specific environment
 * `.zshrc.local`
 * `.gitconfig.local`


How to use
========
    cd ${HOME} && git clone https://github.com/ymkjp/dotfiles.git && . dotfiles/setup.sh

Add .gitlocal
```
[user]
    name  = YOUR_NAME
    email = example@example.com
```
