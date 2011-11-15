syntax on

" vundle
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" from vim.org
Bundle 'Align'
Bundle 'desert.vim'

" from GitHub
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vimproc'
Bundle 'bbommarito/vim-slim'
Bundle 'davidoc/taskpaper.vim'
Bundle 'depuracao/vim-rdoc'
Bundle 'h1mesuke/unite-outline'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'hallison/vim-markdown'
Bundle 'kana/vim-smartchr'
Bundle 'kchmck/vim-coffee-script'
Bundle 'mattn/gist-vim'
Bundle 'mattn/zencoding-vim'
Bundle 'motemen/git-vim'
Bundle 'motemen/vim-guess-abbrev'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'othree/html5.vim'
Bundle 't9md/vim-surround_custom_mapping'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-surround'
Bundle 'ujihisa/unite-colorscheme'
Bundle 'vim-jp/vimdoc-ja'
Bundle 'vim-ruby/vim-ruby'

colorscheme desert
filetype plugin indent on
set ambiwidth=double
set autoindent
set autoread
set smartindent
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoread
set backspace=indent,eol,start
set nobackup
set nocompatible
set noexpandtab
set hidden
set hlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan
set history=100
set laststatus=2
set list
set listchars=tab:>.,precedes:<,extends:>
set number
set showmatch
set whichwrap=b,s,h,l,<,>,[,]
set complete=.,w,b,u,k,i
set completeopt=menu,preview,longest,menuone
set wildmenu
set wildmode=longest:full,list:longest
set scrolloff=100000
set splitbelow
set swapfile
set modeline
set showcmd
set showmode
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp
set encoding=utf-8
set termencoding=utf-8
set fileformats=unix,dos,mac
set directory=~/swp
set statusline=%<\ %f%=%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}[%3l/%3L,%3c]

let mapleader = ' '
let g:mapleader = ' '

nnoremap <Leader><Space> :update<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>
inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', '=')

"" autocmd
"" screenに編集中のファイル名を出す
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]://" | silent! exe '!echo -n "k%\\"' | endif
"" HTMLとかはネストが深くなるのでインデント幅を小さく
autocmd FileType html :set shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType sh inoremap <buffer><expr> = smartchr#loop('=', ' != ')
autocmd FileType ruby inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
autocmd FileType ruby inoremap <buffer><expr> , smartchr#loop(',', ' => ')
autocmd FileType coffee inoremap <buffer><expr> = smartchr#loop(' = ', ' == ', ' === ', '=')
autocmd FileType coffee inoremap <buffer><expr> \ smartchr#one_of(' ->', '\')

"" zencoding.vim
let g:user_zen_leader_key = '<C-e>'

" http://vim-users.jp/2010/07/hack161/
nnoremap <sid>(command-line-enter) q:
xnoremap <sid>(command-line-enter) q:
nnoremap <sid>(command-line-norange) q:<C-u>
nmap : <sid>(command-line-enter)
xmap : <sid>(command-line-enter)

autocmd CmdwinEnter * call s:init_cmdwin()

function! s:init_cmdwin()
	nnoremap <buffer> q :<C-u>quit<CR>
	nnoremap <buffer> <TAB> :<C-u>quit<CR>
	inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
	inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
	inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
	inoremap <buffer><expr><C-h> col('.') == 1 ? "\<ESC>:quit\<CR>" : pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
	inoremap <buffer><expr>: col('.') == 1 ? "VimProcBang " : col('.') == 2 && getline('.')[0] == 'r' ? "<BS>VimProcRead " : ":"
	inoremap <buffer><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
	setlocal nonumber
	startinsert!
endfunction

" http://vim-users.jp/2009/07/hack42/
nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>j <C-w>j:call <SID>good_width()<CR>
nnoremap <C-w>k <C-w>k:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>

function! s:good_width()
	if winwidth(0) < 84
		vertical resize 84
	endif
endfunction

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 3
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
imap <C-k> <Plug>(neocomplcache_snippets_expand)
smap <C-k> <Plug>(neocomplcache_snippets_expand)

" unite.vim
nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>o :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <Leader>r :<C-u>UniteWithBufferDir file_mru<CR>
nnoremap <silent> <Leader>[ :<C-u>Unite outline<CR>
nnoremap <silent> <Leader>. :<C-u>Unite source<CR>
nnoremap <silent> <Leader>' :<C-u>Unite register<CR>
nnoremap <silent> <Leader>u :<C-u>Unite<Space>
au FileType unite nnoremap <silent><buffer><expr><C-s> unite#do_action('split')
au FileType unite inoremap <silent><buffer><expr><C-s> unite#do_action('split')
au FileType unite nnoremap <silent><buffer><expr><C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent><buffer><expr><C-v> unite#do_action('vsplit')

" indent
"au BufEnter,BufWritePost */hekk/* setlocal ts=3 sts=3 sw=3 noet
"au BufEnter,BufWritePost */hekk/* %retab!
"au BufEnter,BufWritePost */hekk/* setlocal ts=3 sts=3 sw=3
"au BufWritePre */hekk/* setlocal ts=3 sts=3 sw=3 et
"au BufWritePre */hekk/* %retab
au BufEnter */hekk/* setlocal ts=2 sts=2 sw=2 et

" surround.vim
let g:surround_custom_mapping = {}
let g:surround_custom_mapping.ruby  = {
	\ '#': "#{\r}",
	\ }
let g:surround_custom_mapping.eruby = {
	\ '-': "<% \r %>",
	\ '=': "<%= \r %>",
	\ '#': "#{\r}",
	\ }

" gabbrev.vim
augroup RUBY
	autocmd!
	autocmd FileType ruby inoremap <buffer> <silent> <expr> <C-]> gabbrev#i_start()
augroup END
