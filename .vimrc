" <3 graywh
syntax on
if has('gui_running')
  colorscheme graywh
else
  colorscheme ir_black
end
set nocompatible
set clipboard=unnamed
set nocompatible
set nowrap
set number
set showmatch
set ttyfast
set title
set wrapmargin=0
set shiftwidth=2
set tabstop=8
set softtabstop=2
set expandtab
set formatoptions=cn
set fileformats=unix,mac,dos
set wildmenu
set wildmode=longest:full,full
set dir=~/.vim/swap//,~/.vim/undo//,/tmp//,.
set undofile
set undolevels=100
set undoreload=100

if has('autocmd') && exists(':filetype') == 2
  filetype plugin indent on
endif

if exists(':syntax') == 2
  syntax enable
  syntax sync fromstart
endif

" show spaces as dots
set listchars=
set listchars+=trail:·
set listchars+=extends:→
set listchars+=precedes:←
set listchars+=tab:»·
set list

" windows, buffers
set hidden
if exists('&switchbuf')
  set switchbuf=useopen
  if v:version >= 700
    set switchbuf+=usetab
  endif
endif
set splitbelow
set splitright

" window nav
nnoremap <silent> <Left>  <C-w>h
nnoremap <silent> <Right> <C-w>l
nnoremap <silent> <Up>    <C-w>k
nnoremap <silent> <Down>  <C-w>j

" remove white space on save
autocmd BufWritePre * :%s/\s\+$//e

" diff mode
if exists('&diffopt')
  set diffopt=filler
  set diffopt+=iwhite
  if v:version >= 700
    set diffopt+=vertical
    set diffopt+=foldcolumn:2
  endif
endif

" vim info
set laststatus=2                " Always display the statusline
set ruler                       " Show position even without status line
set showcmd                     " Show (partial) command in status line
set vb t_vb=                    " Disable visual and audible bell
set history=50                  " Keep 50 lines of command line history
set viminfo=
set viminfo+='100               " Remember 100 previously edited files' marks
set viminfo+=!                  " Remember some global variables
set viminfo+=h                  " Don't restore the hlsearch highlighting
