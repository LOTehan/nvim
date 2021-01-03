"	d8b              d8b   888                       d8b
"	Y8P              Y8P   888                       Y8P
"	                       888
"	888   88888b.    888   888888         888  888   888   88888b.d88b.
"	888   888 "88b   888   888            888  888   888   888 "888 "88b
"	888   888  888   888   888            Y88  88P   888   888  888  888
"	888   888  888   888   Y88b.    d8b    Y8bd8P    888   888  888  888
"	888   888  888   888    "Y888   Y8P     Y88P     888   888  888  888

"Author: @LOTehan

set paste
set tabstop=4

" Automatic installation of missing plugins: https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
" Install vim-plug if not found
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo  ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\| endif


call plug#begin('~/.config/nvim/plugged')

call plug#end()

