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
set modeline
set modelines&
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

if exists(':let') == 2
  let g:fit_manpages_to_window = 1
  let g:leave_my_textwidth_alone = 1
  let g:colorchart_origin = { 88: 0, 256: 7 }
  let g:colorchart_angle = { 88: 0, 256: 4 }
  let g:colorchart_chart = { 88: "ribbon" }

  if &t_Co < 256 && !has('gui_running')
    let g:color_indent_size = 1
    hi! link colorIndentOdd colorIndentEven
  endif

  let g:space_disable_select_mode = 1
  let g:space_no_character_movements = 1
  let g:space_no_search = 1
  let g:space_no_jump = 1

  let g:surround_indent = 1
  " netrw-browse nav
  let g:netrw_retmap = 1
endif

" mouse
if has('mouse')
  set mouse=a                   " Use the mouse for all modes
endif

" keyboard
set notimeout                   " Don't timeout on mappings
set ttimeout                    " Timeout on keycodes
set ttimeoutlen=10              " Keycodes shouldn't take long

" display
if (has('gui_running') || &t_Co > 16) && exists('&cursorline')
  set cursorline                " Highlight the current line
endif

if has('folding')
  set nofoldenable              " Disable folds by default
  set foldmethod=syntax         " Fold by syntax
endif

if exists('&numberwidth')
  set numberwidth=4
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

" buffer nav
"nnoremap <silent> <C-Left>  :bp<CR>
"nnoremap <silent> <C-Right> :bn<CR>
"nnoremap <silent> <C-Up>    :bp<CR>
"nnoremap <silent> <C-Down>  :bn<CR>

" command line completion
cnoremap <expr> <C-p> wildmenumode() ? "\<C-p>" : "\<Up>"
cnoremap <expr> <C-n> wildmenumode() ? "\<C-n>" : "\<Down>"
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>

" searching, pattern matching
set ignorecase                  " Ignore case when searching
set incsearch                   " Incremental search
set smartcase                   " Search case-insensitive mostly
set wrapscan                    " Searches wrap around end of file

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

" reading and writting


" diff mode
if exists('&diffopt')
  set diffopt=filler
  set diffopt+=iwhite
  if v:version >= 700
    set diffopt+=vertical
    set diffopt+=foldcolumn:2
  endif
endif

" remove white space on save
autocmd BufWritePre * :%s/\s\+$//e

" remove trailing new line at end of visual selection yank swag
function! RemoveClipboardNewline()
    if &updatetime==1
        let @*=substitute(@*,'\n$','','g')
        set updatetime=4000
    endif
endfunction
function! VisualEnter()
    set updatetime=1
endfunction
vnoremap <expr> <SID>VisualEnter VisualEnter()
nnoremap <script> V V<SID>VisualEnter
nnoremap <script> gv gv<SID>VisualEnter
autocmd CursorHold * call RemoveClipboardNewline()

" command line completion
cnoremap <expr> <C-p> wildmenumode() ? "\<C-p>" : "\<Up>"
cnoremap <expr> <C-n> wildmenumode() ? "\<C-n>" : "\<Down>"
cnoremap <Up> <C-p>
cnoremap <Down> <C-n>

" graywh functions
if exists(':function') == 2

  function Tmpwatch(path, days)
    let l:path = expand(a:path)
    if isdirectory(l:path)
      for file in split(globpath(l:path, "*"), "\n")
        if localtime() > getftime(file) + 86400 * a:days && delete(file) != 0
          echo "Tmpwatch(): Error deleting '" . file . "'"
        endif
      endfor
    else
      echo "Tmpwatch(): Directory '" . l:path . "' not found"
    endif
  endfunction

  function! SimpleFoldText() " {{{2
    let text = getline(v:foldstart)
    if text[-1:] != ' '
      let text .= ' '
    endif
    return text
  endfunction

  function! MyFoldText() " {{{2
    let suba = getline(v:foldstart)
    let suba = substitute(suba, '{{{\d\=\|}}}\d\=', '', 'g')
    let suba = substitute(suba, '\s*$', '', '')
    " let subb = getline(v:foldend)
    " let subb = substitute(subb, '{{{\d\=\|}}}\d\=', '', 'g')
    " let subb = substitute(subb, '^\s*', '', '')
    " let subb = substitute(subb, '\s*$', '', '')
    let lines = v:foldend - v:foldstart + 1
    let text = suba
    " if lines > 1 && strlen(subb) > 0
    "   let text .= ' ... '.subb
    " endif
    let fillchar = matchstr(&fillchars, 'fold:\zs.')
    if strlen(fillchar) == 0
      let fillchar = '-'
    endif
    let lines = repeat(fillchar, 4).' ' . lines . ' lines '.repeat(fillchar, 3)
    if has('float')
      let nuw = max([float2nr(log10(line('$')))+3, &numberwidth])
    else
      let nuw = &numberwidth
    endif
    let n = winwidth(winnr()) - &foldcolumn - nuw - strlen(lines)
    let text = text[:min([strlen(text), n])]
    if text[-1:] != ' '
      if strlen(text) < n
        let text .= ' '
      else
        let text = substitute(text, '\s*.$', '', '')
      endif
    endif
    let text .= repeat(fillchar, n - strlen(text))
    let text .= lines
    return text
  endfunction

  function! MyFoldIndent() " {{{2
    let line = getline(v:lnum)
    if line =~# '^$'
      return 0
    endif
    let numl = LeadingSpace(line)
    if line =~# &formatlistpat && &formatoptions =~# 'n'
      return '>' . ((numl  / &shiftwidth) + 1)
    endif
    if (numl % &shiftwidth) > 0 || numl == 0
      return '='
    endif
    return numl / &shiftwidth
  endfunction

  function! LeadingSpace(line) " {{{2
    let line = substitute(a:line, '^\(\s*\)\S.*$', '\1', '')
    let line = substitute(line, '\t', repeat(' ', &tabstop), 'g')
    return strlen(line)
  endfunction

  function! StatusLineTrailingSpaceWarning() " {{{2
    " return '[\s$]' if trailing whitespace is detected
    " return '' otherwise
    if !exists('b:statusline_trailing_space_warning')
      if !&readonly && &modifiable && search('\s\+$', 'nw') != 0
        let b:statusline_trailing_space_warning = '[\s$]'
      else
        let b:statusline_trailing_space_warning = ''
      endif
    endif
    return b:statusline_trailing_space_warning
  endfunction

  function! StatusLineTabWarning() " {{{2
    " return '[&et]' if &expandtab is set wrong
    " return '[mixed-indenting]' if spaces and tabs are used to indent
    " return an empty string if everything is fine
    if !exists('b:statusline_tab_warning')
      if &filetype == 'help' || &readonly == 1 || &modifiable == 0
        let b:statusline_tab_warning = ''
      else
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0
        if tabs && spaces
          let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&expandtab) || (tabs && &expandtab)
          let b:statusline_tab_warning = '[&et]'
        else
          let b:statusline_tab_warning = ''
        endif
      endif
    endif
    return b:statusline_tab_warning
  endfunction

  function! StatusLineEncodingBombWarning() " {{{2
    if &fileencoding !~ '^$\|utf-8' || &bomb
      return '[' . &fileencoding . (&bomb ? '-bom' : '') . ']'
    else
      return ''
    endif
  endfunction

  if exists('*synstack') " {{{2
    function! ShowSynStack()
      echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
    endfunction
  endif

  function! ShowSynIDs() " {{{2
    let id = synID(line('.'),col('.'),1)
    let hi = synIDattr(id,'name')
    let trans = synIDattr(synID(line('.'),col('.'),0),'name')
    let lo = synIDattr(synIDtrans(id),'name')
    echo 'hi<' . hi . '> trans<' . trans . '> lo<' . lo . '>'
  endfunction

  function! VisualNavigation() " {{{2
    let mds = ['n', 'o', 'x']
    let keys = ['0', '^', '$', '<Home>', '<End>', 'k', 'j', '<Up>', '<Down>']
    if !exists('b:my_visual_navigation_maps')
      let b:my_visual_navigation_maps = 1
      echomsg 'Enabled visual navigation'
      setlocal wrap
      for key in keys
        for md in mds
          if mapcheck(key, md) == ''
            exec 'silent '.md.'noremap <buffer> <unique> '.key.' g'.key
          endif
        endfor
      endfor
    else
      unlet b:my_visual_navigation_maps
      echomsg 'Disabled visual navigation'
      setlocal wrap<
      for key in keys
        for md in mds
          if mapcheck(key, md) == 'g'.key
            exec 'silent '.md.'unmap <buffer> '.key
          endif
        endfor
      endfor
    endif
  endfunction

  function! LastModified() "{{{2
    " autocmd BufWritePre * call LastModified()
    if &modified
      let save_cursor = getpos(".")
      silent! keepjumps 1,4substitute/ Last Modified: \zs.*/\=strftime('%c')/
      call setpos('.', save_cursor)
    endif
  endfunction

  function! InvertColors() "{{{2
    let swapbw = { 'Black' : 'White', 'White' : 'Black' }
    %substitute/\<cterm[fb]g=\zs\(Black\|White\)/\=get(swapbw, submatch(1), '')/g
    let swap = { 'Red' : 'Cyan', 'Green' : 'Magenta', 'Yellow' : 'Blue', 'Blue' : 'Yellow', 'Magenta' : 'Green', 'Cyan' : 'Red', 'Gray' : 'Gray', 'Grey' : 'Grey', 'Light' : 'Dark', 'Dark' : 'Light' }
    %substitute/\<cterm[fb]g=\zs\(Dark\|Light\)\=\(Red\|Green\|Yellow\|Blue\|Magenta\|Cyan\|Gr[ae]y\)/\=get(swap, submatch(1), 'Dark') . get(swap, submatch(2), '')/g
    %substitute/\<gui\(fg\|bg\|sp\)=#\zs\(\x\{6}\)/\=printf('%06X', 16777215 - str2nr(submatch(2), 16))/g
  endfunction

endif

" graywh status line
set statusline=
set statusline+=%4(%n%)\                " Buffer number (4 columns, lines up with the line numbers most of the time)
set statusline+=%<%f\                   " Relative filename & path (truncatable)
set statusline+=%y%m%r%w                " Flags: filetype, modified/nomodifiable, read-only, preview
set statusline+=%1*                     " Various warnings
set statusline+=%{StatusLineTabWarning()}               " Indentation
set statusline+=%{StatusLineTrailingSpaceWarning()}     " Trailing space
set statusline+=%{&ff=='unix'?'':'['.&ff.']'}           " &fileformat != 'unix'
set statusline+=%{StatusLineEncodingBombWarning()}      " &fileencoding, &bomb
set statusline+=%{&eol?'':'[noeol]'}                    " &noeol
set statusline+=%*                      " End of warnings section
set statusline+=%=\                     " Separate left from right
set statusline+=%b,0x%-8B\              " Current character in decimal and hex representation
set statusline+=%-12(%l,%c%V%)\ %P      " Current line and column, file percentage (set 'ruler')
