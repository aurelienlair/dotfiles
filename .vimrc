" GENERAL SETTINGS
set nocompatible 
set fileformat=unix
set encoding=utf-8 
set number
syn on
set nocompatible
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp
set shiftwidth=4
set tabstop=4
set softtabstop=4
set ignorecase
set expandtab
set nopaste
set autoindent
set comments=sr:/*,mb:*,ex:*/

set incsearch
set hlsearch
set wrapscan
set history=2000

" REMAPPING OF KEYBOARD KEYS
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

autocmd FileType php noremap <C-M> :!clear<CR>:w!<CR>:!/usr/bin/php %<CR>
autocmd FileType php noremap <C-K> :!clear<CR>:!/usr/bin/php -d display_errors=1 -l %<CR>
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab

" PLUGGED SETTINGS "
call plug#begin('~/.vim/plugged')
  Plug 'kien/ctrlp.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'embear/vim-localvimrc'
  Plug 'scrooloose/nerdTree'
  Plug 'scrooloose/syntastic'
call plug#end()

" NERDTREE SETTINGS
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-y> :tabnew<CR>
map  <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>

" CTRLP SETTINGS "
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|work|swp)$',
    \ 'file': '\v\.(gitmodules|gitignore)$',
    \ } 

" ACK SETTINGS "
if !exists("g:ackprg")
  let s:ackcommand = executable('ack-grep') ? 'ack-grep' : 'ack'
  let g:ackprg=s:ackcommand." --nogroup --column --ignore-dir=.work"
endif

if !exists("g:ack_apply_qmappings")
  let g:ack_apply_qmappings = !exists("g:ack_qhandler")
endif

if !exists("g:ack_apply_lmappings")
  let g:ack_apply_lmappings = !exists("g:ack_lhandler")
endif

if !exists("g:ack_qhandler")
  let g:ack_qhandler="botright copen"
endif

if !exists("g:ack_lhandler")
  let g:ack_lhandler="botright lopen"
endif

function! s:Ack(cmd, args)
  redraw
  echo "Searching ..."

  " If no pattern is provided, search for the word under the cursor
  if empty(a:args)
    let l:grepargs = expand("<cword>")
  else
    let l:grepargs = a:args . join(a:000, ' ')
  end

  " Format, used to manage column jump
  if a:cmd =~# '-g$'
    let g:ackformat="%f"
  else
    let g:ackformat="%f:%l:%c:%m"
  end

  let grepprg_bak=&grepprg
  let grepformat_bak=&grepformat
  try
    let &grepprg=g:ackprg
    let &grepformat=g:ackformat
    silent execute a:cmd . " " . escape(l:grepargs, '|')
  finally
    let &grepprg=grepprg_bak
    let &grepformat=grepformat_bak
  endtry

  if a:cmd =~# '^l'
    exe g:ack_lhandler
    let l:apply_mappings = g:ack_apply_lmappings
  else
    exe g:ack_qhandler
    let l:apply_mappings = g:ack_apply_qmappings
  endif

  if l:apply_mappings
    exec "nnoremap <silent> <buffer> q :ccl<CR>"
    exec "nnoremap <silent> <buffer> t <C-W><CR><C-W>T"
    exec "nnoremap <silent> <buffer> T <C-W><CR><C-W>TgT<C-W><C-W>"
    exec "nnoremap <silent> <buffer> o <CR>"
    exec "nnoremap <silent> <buffer> go <CR><C-W><C-W>"
    exec "nnoremap <silent> <buffer> h <C-W><CR><C-W>K"
    exec "nnoremap <silent> <buffer> H <C-W><CR><C-W>K<C-W>b"
    exec "nnoremap <silent> <buffer> v <C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t"
    exec "nnoremap <silent> <buffer> gv <C-W><CR><C-W>H<C-W>b<C-W>J"
  endif

  " If highlighting is on, highlight the search keyword.
  if exists("g:ackhighlight")
    let @/=a:args
    set hlsearch
  end

  redraw!
endfunction

command! -bang -nargs=* -complete=file Ack call s:Ack('grep<bang>',<q-args>)

let &shellpipe='2>/dev/null>'


" SYNTASTIC SETTINGS
let g:syntastic_php_checkers=['php']
let g:syntastic_javascript_checkers = ['jshint']

"enable undo persistence for all but tmp files
set undofile
set undodir=$HOME/.vim/undo
autocmd BufWritePre /tmp/* setlocal noundofile
autocmd BufWritePre */.git/COMMIT_EDITMSG setlocal noundofile

function! CurrentNamespace()
    let path = split(expand("%:p"), "/")
    let pathInverted = copy(path)
    call reverse(pathInverted)
    let rootFolder = -1
    for folder in pathInverted
        let firstCharacter = strpart(folder, 0, 1)
        if (firstCharacter ==# toupper(firstCharacter))
            let rootFolder = rootFolder - 1
        else
            break
        endif
    endfor
    let namespace = join(path[rootFolder+1:-2], "\\")
    return namespace
endfunction
