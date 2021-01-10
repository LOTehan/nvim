"	d8b              d8b   888                       d8b
"	Y8P              Y8P   888                       Y8P
"	                       888
"	888   88888b.    888   888888         888  888   888   88888b.d88b.
"	888   888 '88b   888   888            888  888   888   888 '888 '88b
"	888   888  888   888   888            Y88  88P   888   888  888  888
"	888   888  888   888   Y88b.    d8b    Y8bd8P    888   888  888  888
"	888   888  888   888    "Y888   Y8P     Y88P     888   888  888  888

"Author: @LOTehan

"=>Get prepatched fonts from https://github.com/powerline/fonts
"==============================================================
set paste
set tabstop=4
set mouse=a
set nu
set relativenumber 
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>

map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>l <C-w>l

map <LEADER><UP> :res +5<CR>
map <LEADER><DOWN> :res -5<CR>
map <LEADER><LEFT> :vertical resize-5<CR>
map <LEADER><RIGHT> :vertical resize+5<CR>

" Automatic installation of missing plugins````````````````````````````````````
" @https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

" Windows10 x64
if(has('win64'))
	if empty(glob('$LOCALAPPDATA/nvim-data/site/autoload/plug.vim'))
		" Set shell-unquoting for Windows PowerShell
		" @https://neovim.io/doc/user/options.html#shell-powershell
		set shell=powershell.exe
		set shellquote= shellpipe=\| shellxquote=
		set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command
		set shellredir=\|\ Out-File\ -Encoding\ UTF8

		" Install vim-plug if not found
		silent !iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim	|`
			\	ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

		" Reset shell-unquoting for Windoes cmd
		set shell=cmd.exe
		set shellquote= shellpipe=>\%s\ 2>&1 shellxquote="
		set shellcmdflag=/s\ /c
		set shellredir=>\%s\ 2>&1
	endif

" Unix
elseif(has('unix'))
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
		" Install vim-plug if not found
		silent !curl -fLo  ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
			\	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	endif
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\|	PlugInstall --sync | source $MYVIMRC
	\|	endif
" `````````````````````````````````````````````````````````````````````````````

" Support Chinese characters
set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom
set termencoding=utf-8
set encoding=utf-8

" Restore cursor
" @https://vimhelp.org/usr_05.txt.html#last-position-jump
au BufReadPost *
	\	if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\|	exe "normal! g`\""
	\|	endif


if(has('win64'))
	call plug#begin('$LOCALAPPDATA/nvim/plugged')
elseif(has('unix'))
	call plug#begin('~/.config/nvim/plugged')
endif

	Plug 'vim-airline/vim-airline'
		" Integrating with powerline fonts
		"=>Get prepatched fonts from https://github.com/powerline/fonts
		let g:airline_powerline_fonts = 1

		" Get vim-airline-themes repository for more themes
		Plug 'vim-airline/vim-airline-themes'
			let g:airline_theme='dark_minimal'

		" Smarter tab line
		let g:airline#extensions#tabline#enabled = 1
			let g:airline#extensions#tabline#formatter = 'unique_tail_improved' 

		" Define the set of text to display for each mode
		let g:airline_mode_map = {
			\ '__'     : '-',
			\ 'c'      : 'C',
			\ 'i'      : 'I',
			\ 'ic'     : 'I',
			\ 'ix'     : 'I',
			\ 'n'      : 'N',
			\ 'multi'  : 'M',
			\ 'ni'     : 'N',
			\ 'no'     : 'N',
			\ 'R'      : 'R',
			\ 'Rv'     : 'R',
			\ 's'      : 'S',
			\ 'S'      : 'S',
			\ ''     : 'S',
			\ 't'      : 'T',
			\ 'v'      : 'V',
			\ 'V'      : 'V',
			\ ''     : 'V',
			\ }

		"Display a short path in statusline: >
		let g:airline_stl_path_style = 'short'

		""":AirlineExtensions Shows the status of all available airline extensions.

	Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
		" Open preview server in the network
		let g:mkdp_open_to_the_world = 1

call plug#end()
