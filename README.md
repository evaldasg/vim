# vim
```bash
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
```bash
mkdir ~/.vim/swp ~/.vim/backup ~/.vim/undo
```
```bash
cd ~/.vim
git init
git remote add origin git@github.com:manoevis/vim.git
git fetch
git checkout -t origin/master
```
```bash
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/vimrc.bundles ~/.vimrc.bundles
```
my personal **vim** config
