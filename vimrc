set nocompatible
let mapleader = ","

" Load plugins that ship with Vim {{{1
"runtime macros/matchit.vim
"runtime ftplugin/man.vim

" Load bundled plugins {{{1
call pathogen#infect()
call pathogen#helptags()

" Autocommands {{{1
if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent " always set autoindenting on
endif

" Preferences {{{1

" Behaviour {{{2
set backspace=indent,eol,start
set history=50
set incsearch
set visualbell t_vb=
set hidden
set nojoinspaces
set nrformats=

" Tab-completion in command-line mode
set wildmode=full
set wildmenu
set wildignore=*.pdf,*.fo,*.xml
set suffixes=.otl

" Appearance {{{2
set ruler
set showcmd
set laststatus=2
set listchars=tab:▸\ ,eol:¬
set number
" set cursorline

" When the terminal has colors, enable syntax+search highlighting
syntax on
set hlsearch

" Indentation {{{2
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Enable persistent undo {{{2
set undofile
set undodir=~/tmp/vim/undo
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif

" Disable swapfile and backup {{{2
set nobackup
set noswapfile
" }}}

" Mappings {{{1

" NerdTree toggle {{{2
map <leader>n :NERDTreeToggle<CR>

" NerdCommenter toggle {{{2
map <leader>/ <plug>NERDCommenterToggle<CR>
imap <leader>/ <plug>NERDCommenterToggle<CR>i


" Strip trailing whitespace {{{2
function! Preserve(command)
" Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
" Do the business:
  execute a:command
" Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Custom commands {{{1"{{{
" :CloseHiddenBuffers {{{2
" Wipe all buffers which are not active (i.e. not visible in a window/tab)
" Using elements from each of these:
" http://stackoverflow.com/questions/2974192
" http://stackoverflow.com/questions/1534835
command! -nargs=* Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
" figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
" close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun

" Gundo.vim {{{2
map <Leader>u :GundoToggle<CR>

hi LineNr  ctermfg=darkgrey ctermbg=black
hi Comment ctermfg=darkgrey

