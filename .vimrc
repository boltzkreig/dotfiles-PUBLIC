".vimrc "DONT_MESS	

"!" For different computer"!"
if has('win32')
	:set backspace=2
	:set guifont=Consolas:h15
	:set belloff=all
	:command -bar Set :vsp | :wincmd l | :e C:\Users\Pousteryx\_vimrc
	:command -bar CE :w | :!g++ % & echo.  & .\a.exe & echo. 

	"!" :Set will open _vimrc in side window""!"
	"!":command -bar SET :tabe C:\Users\Pousteryx\_vimrc"!"
	"!":nnoremap gx :!opera.lnk "<c-r><c-a>" >> C:\Users\Pousteryx\Desktop\see.txt<CR>"!"
	"!""Bad patchup for stopping windows from downloading whole webpage code"!"
	:nnoremap gx :!opera.lnk "<c-r><c-a>"<CR>
	:nnoremap gf :tabe <cfile><CR>
	:nnoremap gi :!<cfile><CR>
	:set path+=C:\Users\Pousteryx\Desktop\Gamma\
	:set undodir=/usr/share/vim\vimfiles\vim_undo\
else
	command  -bar Set :vsp | :wincmd l | :e $HOME/.vimrc
	command -bar CE :w | :!g++ % && ./a.out
	set undodir=/home/bolt/.vim/undo/
	set guifont=Source\ Code\ Pro\ Semibold:h18
	set mouse=a
	set mousehide
endif

"set sxe+=;
set nu      "rnu
set spell
set syntax=python
filetype on
filetype plugin on
set encoding=utf-8
set clipboard=unnamed

set smartindent
set shiftround
set smartcase
set modelines=1
set showcmd
set showmode
set laststatus=2
set nocompatible
set cursorline
set cursorcolumn
set list listchars=trail:�,tab:���

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set noswapfile
set nowrap
set undofile

syntax on
filetype indent on 
set complete+=kspell
set completeopt=menuone,longest
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
 \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
command T :below vertical terminal
command E :Vexplore
let mapleader = " "

set showmatch
set hlsearch
set incsearch
set wildmenu
set wildmode=list:longest
"longest:full,full

"CUSTOM KEYBINDINGS"
":nnoremap s "+p
nnoremap <M-p> "ayy"ap
if (has("clipboard"))
	nnoremap <leader>y "+yy
	vnoremap <leader>y "+y
	nnoremap <leader>p "+p
else
	vnoremap <leader>y :w !xsel -i -b<CR><CR>
	nnoremap <leader>y <S-v>:w !xsel -i -b<CR><CR>
	nnoremap <leader>p :r !xsel -o -b<CR>
endif

"nnoremap > :cn<CR>
"nnoremap < :cp<CR>

nnoremap <tab> o<esc>
nnoremap <BS> :.g/^$/d<cr>:noh<cr>
nnoremap <leader><leader> :noh<CR>

"inoremap  <esc> "Ctrl+s"
"nnoremap  <esc> "Ctrl+s"

nnoremap <C-Left> :tabp<CR>
nnoremap <C-Right> :tabn<CR>

nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

nnoremap <S-tab> I#<esc>
autocmd FileType c     nnoremap <S-tab> I//<esc>
autocmd FileType cpp   nnoremap <S-tab> I//<esc>
autocmd FileType shell nnoremap <S-tab> I"<esc>

call plug#begin()
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'dense-analysis/ALE'
Plug 'frazrepo/vim-rainbow'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mbbill/undotree'
Plug 'dhruvasagar/vim-table-mode'
Plug 'vimwiki/vimwiki'

"Plug 'christoomey/vim-tmux-navigator'
"Plug 'tmux-plugin/vim-tmux'

"Plug 'EdenEast/nightfox.nvim'
"Plug 'cocopon/iceberg.vim'
"Plug 'pineapplegiant/spaceduck'
"Plug 'rebelot/kanagawa.nvim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-syntastic/syntastic'
Plug 'haishanh/night-owl.vim'
Plug 'mangeshrex/everblush.vim'

call plug#end()

let g:rainbow_active = 1
command  Com  :Commands
highlight VertSplit ctermbg=7 ctermfg=15

if (has("termguicolors"))
	 set termguicolors
endif
if empty($DISPLAY)
	colorscheme desert
else
	colorscheme night-owl
endif

nnoremap <F7>  :TableModeToggle<CR>
nnoremap <F8>  :NERDTreeToggle<CR>
nnoremap <F9>  :Files<CR>
nnoremap <F10> :UndotreeToggle<CR>

"https://learnbyexample.gitbooks.io/vim-reference/content/Command_Line_mode.html

"	
" 
"

fun! Start()
    " Don't run if: we have commandline arguments, we don't have an empty
    " buffer, if we've not invoked as vim or gvim, or if we'e start in insert mode
    if argc() || line2byte('$') != -1 || v:progname !~? '^[-gmnq]\=vim\=x\=\%[\.exe]$' || &insertmode
        return
    endif

    " Start a new buffer ...
	enew
	if empty($DISPLAY)
		let l:insignia = systemlist('cat ~/Unicode.txt')
	else
		let l:insignia = systemlist('cat ~/Braille.txt')
	endif

	call append('0', ['', ''] + map(l:insignia, '"       ".v:val'))
	:1
	redraw!

    " ... and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber
        \ nospell
        \ nomodifiable
        \ nomodified
    " Now we can just write to the buffer, whatever you want.

    "call append('$', "This is a new file in vim ")

    " No modifications to this buffer

	60 vnew
	call append('0', ['', ''] + map(systemlist('vim-info 2> /dev/null'), '"       ".v:val'))
	:1
	redraw!

    " ... and set some options for it
    setlocal
        \ bufhidden=wipe
        \ buftype=nofile
        \ nobuflisted
        \ nocursorcolumn
        \ nocursorline
        \ nolist
        \ nonumber
        \ noswapfile
        \ norelativenumber
        \ nospell
        \ nomodifiable 
        \ nomodified
    " When we go to insert mode start a new buffer, and start insert
    cnoremap <buffer><silent> q<CR> :q!<CR> :q!<CR>
    nnoremap <buffer><silent> e :q!<CR> :enew<CR>
    nnoremap <buffer><silent> i :q!<CR> :enew <bar> startinsert<CR>
endfun

" Run after "doing all the startup stuff"
autocmd VimEnter * call Start()
