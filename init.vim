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

"set paste
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
			\ ''     : 'V',
			\ }

		"Display a short path in statusline
		let g:airline_stl_path_style = 'short'

		" Enable coc integration
		let g:airline#extensions#coc#enabled = 1
			" change error symbol
			let airline#extensions#coc#error_symbol = 'E:'
			" change warning symbol: >
			let airline#extensions#coc#warning_symbol = 'W:'
			" change error format: >
			let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
			" change warning format: >
			let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

		""":AirlineExtensions Shows the status of all available airline extensions.

	" Markdown environment`````````````````````````````````````````````````````

	" Markdown preview with plantuml plugin
	"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

		" Open preview server in the network
		"let g:mkdp_open_to_the_world = 1

		" Open the preview window after entering the Md buffer
		"let g:mkdp_auto_start = 1

		" Use port 8900 to start server
		"let g:mkdp_port = '8090'

	" Automatic table creator and formatter
	Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
	""":TableModeToggle mapped to <Leader>tm by default

	" Markdown preview
	"=>Get the mini-server by runing `sudo npm -g install instant-markdown-d`
	Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
		
		" Cause plugin to only refresh on proper events
		"let g:instant_markdown_slow = 1
		
		" Disable automatically launching preview window after entering
		let g:instant_markdown_autostart = 0

		" Open preview server in the network
		let g:instant_markdown_open_to_the_world = 1

		" Allow scripts to run
		let g:instant_markdown_allow_unsafe_content = 1
		
		" Block external resources such as images, stylesheets, frames and plugins
		"let g:instant_markdown_allow_external_content = 0
		
		" Available the TeX code embedded with markdown
		let g:instant_markdown_mathjax = 1

		" Available the mermaid diagrams
		let g:instant_markdown_mermaid = 1

		" Detect the browser
		"let g:instant_markdown_browser = "firefox --new-window"

		" Disable the live preview to where your cursor is positioned
		"let g:instant_markdown_autoscroll = 0

		" Set a custom port instead of the default '8090'
		"let g:instant_markdown_port = 8090

	" `````````````````````````````````````````````````````````````````````````

	Plug 'neoclide/coc.nvim', {'branch': 'release'}
		
		" TextEdit might fail if hidden is not set.
		set hidden

		" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
		set updatetime=100

		" Don't pass messages to |ins-completion-menu|.
		set shortmess+=c

		" Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved.
		set signcolumn=yes

		" Use tab for trigger completion with characters ahead and navigate.
		" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin before putting this into your config.
		inoremap <silent><expr> <TAB>
			\	pumvisible() ? "\<C-n>" :
			\	<SID>check_back_space() ? "\<TAB>" :
			\	coc#refresh()
		inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
		function! s:check_back_space() abort
			let col = col('.') - 1
			return !col || getline('.')[col - 1]  =~# '\s'
		endfunction

		" Use <c-space> to trigger completion.
		inoremap <silent><expr> <c-space> coc#refresh()

		" Make <CR> auto-select the first completion item and notify coc.nvim to format on enter, <cr> could be remapped by other vim plugin
		inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\	: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

		" Use `[g` and `]g` to navigate diagnostics, use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
		nmap <silent> [g <Plug>(coc-diagnostic-prev)
		nmap <silent> ]g <Plug>(coc-diagnostic-next)

		" GoTo code navigation.
		nmap <silent> gd <Plug>(coc-definition)
		nmap <silent> gy <Plug>(coc-type-definition)
		nmap <silent> gi <Plug>(coc-implementation)
		nmap <silent> gr <Plug>(coc-references)

		" Use K to show documentation in preview window.
		nnoremap <silent> K :call <SID>show_documentation()<CR>
		function! s:show_documentation()
			if (index(['vim','help'], &filetype) >= 0)
				execute 'h '.expand('<cword>')
			elseif (coc#rpc#ready())
				call CocActionAsync('doHover')
			else
				execute '!' . &keywordprg . " " . expand('<cword>')
			endif
		endfunction

		" Highlight the symbol and its references when holding the cursor.
		autocmd CursorHold * silent call CocActionAsync('highlight')

		" Symbol renaming.
		nmap <leader>rn <Plug>(coc-rename)

		" Formatting selected code.
		xmap <leader>f  <Plug>(coc-format-selected)
		nmap <leader>f  <Plug>(coc-format-selected)
		augroup mygroup
			autocmd!
			" Setup formatexpr specified filetype(s).
			autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
			" Update signature help on jump placeholder.
			autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
		augroup end



		"cd ~/.config/coc/extensions/node_modules/coc-ccls
		"ln -s node_modules/ws/lib lib
		let g:coc_global_extensions = [
			\	'coc-marketplace',
			\	'coc-json',
			\	'coc-ccls',
			\	'coc-vimlsp'
			\	]

call plug#end()

" Run Compile `````````````````````````````````````````````````````````````````

" Use `r` to compile
noremap r :call RunCompile()<CR>

func! RunCompile()
	" Autosave
	exec "w"

	if &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	endif
endfunc
" `````````````````````````````````````````````````````````````````````````````

" Macro format in markdown
autocmd Filetype markdown inoremap <buffer> ,f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> ,w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> ,b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> ,s ~~~~ <++><Esc>F~hi
autocmd Filetype markdown inoremap <buffer> ,i ** <++><Esc>F*i
autocmd Filetype markdown inoremap <buffer> ,d `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> ,m - [ ] 
autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> ,l --------<Enter>

