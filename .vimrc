" Use Vim settings rather than Vi settings
set nocompatible

" Required for Vundle
filetype off

" Use Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Vundle Packages

" Let vundle manage itself:
Bundle 'gmarik/Vundle.vim'

Bundle 'flazz/vim-colorschemes'

Bundle 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_open_new_file = 'r'

Bundle 'tpope/vim-commentary'

Bundle 'bling/vim-airline'

Bundle 'tpope/vim-fugitive'

Bundle 'scrooloose/syntastic'

Bundle 'airblade/vim-gitgutter'

Bundle 'Raimondi/delimitMate'
au! FileType clojure let b:loaded_delimitMate=1

Bundle 'sheerun/vim-polyglot'

Bundle 'jmcantrell/vim-virtualenv'

Bundle 'rking/ag.vim'

Bundle 'Valloric/YouCompleteMe'

Bundle 'marijnh/tern_for_vim'

Bundle 'benmills/vimux'

Bundle 'christoomey/vim-tmux-navigator'

Bundle 'mattn/emmet-vim'

Bundle 'tpope/vim-rails'

Bundle 'elixir-lang/vim-elixir'

Bundle 'mattreduce/vim-mix'

Bundle 'MarcWeber/vim-addon-local-vimrc'

Bundle 'guns/vim-sexp'

Bundle 'tpope/vim-fireplace'

Bundle 'tpope/vim-salve'

Bundle 'tpope/vim-sexp-mappings-for-regular-people'

Bundle 'tpope/vim-surround'

Bundle 'tpope/vim-dispatch'

Bundle 'luochen1990/rainbow'
let g:rainbow_active = 1

Bundle 'godlygeek/tabular'

" Reactivate now that Vundle has run
filetype plugin indent on " Filetype auto-detection
syntax on " Syntax highlighting
syntax enable

set tabstop=4
set shiftwidth=2
set softtabstop=4
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
set smartindent " Intellegently dedent / indent new lines based on rules.
set backspace=2 " Make backspace work like most other apps.
set number " Turn on line numbers
set clipboard=unnamed " Make clipboard work with Vim

" We have VCS -- we don't need this stuff.
set nobackup " We have vcs, we don't need backups.
set nowritebackup " We have vcs, we don't need backups.
set noswapfile " They're just annoying. Who likes them?

" don't nag me when hiding buffers
set hidden " allow me to have buffers with unsaved changes.
set autoread " when a file has changed on disk, just load it. Don't ask.

" Make search more sane
set ignorecase " case insensitive search
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block

" leader is a key that allows you to have your own "namespace" of keybindings.
" You'll see it a lot below as <leader>
let mapleader = "\<space>"

" So we don't have to reach for escape to leave insert mode.
inoremap jf <esc>

" create new vsplit, and switch to it.
noremap <leader>v <C-w>v

" bindings for easy split nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Use sane regex's when searching
nnoremap / /\v
vnoremap / /\v

" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk

" Plugin settings:
" Below are some 'sane' (IMHO) defaults for a couple of the above plugins I
" referenced.

" Map the key for toggling comments with vim-commentary
noremap <leader>c <Plug>CommentaryLine

" Better mapping for ctrlp
noremap <leader>p :CtrlP<CR>
noremap <leader>b :CtrlPBuffer<CR>

" Finally the color scheme. Choose whichever you want from the list in the
" link above (back up where we included the bundle of a ton of themes.)
colorscheme jellyx
" colorscheme vividchalk
" colorscheme flatland
" colorscheme distinguished

" Activate mouse support
set mouse=a

" CtrlP Configuration.
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.svn$\|\htmlcov$\|\node_modules$\|deps\|_build\|target\|tmp',
  \ 'file': '\.exe$\|\.pyc$',
  \ }
set wildignore+=*/node_modules/*
set wildignore+=bower_components
let g:ctrlp_max_height = 30


" Airline Configuration.
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_detect_paste = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='bubblegum'
set background=dark
let g:airline_section_y = airline#section#create('venv: %{virtualenv#statusline()}')

" Syntastic Configuration.
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
let g:syntastic_python_pyflakes_args = '--load-plugins pylint_django'
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" delimitMate Configuration.
" let delimitMate_expand_cr = 1
augroup mydelimitMate
  au!
  au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
  au FileType tex let b:delimitMate_quotes = ""
  au FileType tex let b:delimitMate_matchpairs = "(:),[:],{:},`:'"
  au FileType python let b:delimitMate_nesting_quotes = ['"', "'"]
augroup END

" vim emmet configuration
inoremap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_install_global = 0
autocmd FileType html,css,eex,erb EmmetInstall
let g:user_emmet_expandabbr_key = '<Tab>'

" required to show colors properly in tmux
if exists('$TMUX')
  set term=screen-256color
endif

" for tmux to automatically set paste and nopaste mode at the time pasting (as
" happens in VIM UI)

function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif
 
  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function RunWith (command)
  execute "w"
  execute "!clear;time " . a:command . " " . expand("%")
endfunction

autocmd FileType ruby inoremap <buffer><F5> <Esc>:call RunWith("ruby")<CR>
autocmd FileType ruby nnoremap <buffer><F5> :call RunWith("ruby")<CR>
autocmd FileType elixir inoremap <buffer><F5> <Esc>:call RunWith("elixir")<CR>
autocmd FileType elixir nnoremap <buffer><F5> :call RunWith("elixir")<CR>

" format JSON files using python.tools
:command FormatJson %!python -m json.tool

" format XML files using tidy
:command FormatXml %!tidy -xml -q -i

" experimenting with sending vimux commands
function! VimuxSlime()
  call VimuxSendText(@v)
  call VimuxSendKeys("Enter")
endfunction
vnoremap <leader>vs "vy :call VimuxSlime()<CR>

cabbrev !! VimuxRunCommand

" code folding
set foldmethod=indent
set foldignore=
set foldlevelstart=99
