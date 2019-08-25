set encoding=utf-8

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/bundle/plug.vim')

Plug 'scrooloose/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'luochen1990/rainbow'
Plug 'tomasr/molokai'
Plug 'tmhedberg/SimpylFold'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !/root/miniconda/bin/python install.py
  endif
endfunction

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

" Initialize plugin system
call plug#end()

syntax on

let mapleader = ","
let maplocalleader = "\\"

filetype plugin on
set omnifunc=syntaxcomplete#Complete

" For some reason backspace does not work without this
set backspace=start,eol,indent

set shiftwidth=4
set tabstop=4
set softtabstop=4
au FileType scala setlocal shiftwidth=2 tabstop=2 softtabstop=2
au FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
au BufRead,BufNewFile *.cc,*.h setlocal shiftwidth=2 tabstop=2 softtabstop=2
set expandtab " Use spaces for tab
set autoindent
set smartindent
"set paste
set pastetoggle=<F2>
"set clipboard+=unnamed
vmap <Leader>y "+y

autocmd BufNewFile,BufRead *.c.src set syntax=c

" Show invisible whitespace
set list
set listchars=trail:·,tab:»·
",space:.
"hi SpecialKey ctermfg=7 guifg=blue

" Auto remove trailing whitespace when save
autocmd BufWritePre * %s/\s\+$//e

" Set color scheme
silent! colorscheme molokai

" Check spelling
setlocal spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline

set colorcolumn=88
highlight ColorColumn ctermbg=235 guibg=lightgrey
set hlsearch

" set folding by syntax
"set foldmethod=syntax

" set line number
set nu

" Print option
set printoptions=paper:letter,syntax:y,wrap:y,duplex:long

let g:rainbow_active = 1

" Indent Line
let g:indentLine_color_term = 246
nnoremap <Leader>w :w <bar> :IndentLinesReset

" indentLine changes conceal level
let g:indentLine_setConceal = 0

" NerdTree
autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

" vim-markdown syntax highlighting
let g:vim_markdown_folding_disabled = 1

set secure
