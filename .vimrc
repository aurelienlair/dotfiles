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
set noswapfile

set incsearch
set hlsearch
set wrapscan
set history=2000
" FOR AIRLINE BAR
set laststatus=2
set backspace=indent,eol,start

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
autocmd Filetype clojure setlocal ts=2 sw=2 expandtab

" PLUGGED SETTINGS "
call plug#begin('~/.vim/plugged')
" EDITING
  Plug 'kien/ctrlp.vim'
  Plug 'scrooloose/nerdTree'
  Plug 'vim-scripts/paredit.vim'
" SYNTAX
  Plug 'scrooloose/syntastic'
" UTILS 
  Plug 'tpope/vim-fugitive'
  Plug 'garbas/vim-snipmate'
  Plug 'honza/vim-snippets'
  Plug 'vim-airline/vim-airline'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
" CONFIG
  Plug 'embear/vim-localvimrc'
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
" exlude tmp files
" autocmd BufWritePre /tmp/* setlocal noundofile
" autocmd BufWritePre */.git/COMMIT_EDITMSG setlocal noundofile

" PHPUNIT SHORTCUT
nnoremap <silent> <Leader>t :setlocal nocursorline <BAR> call RunCurrentTest('') <BAR> setlocal cursorline<CR>
nnoremap <silent> <Leader>T :setlocal nocursorline <BAR> call RunCurrentTest('--stop-on-failure') <BAR> setlocal cursorline<CR>
nnoremap <silent> <Leader>l :setlocal nocursorline <BAR> call RunLastTest() <BAR> setlocal cursorline<CR>
nnoremap <silent> <Leader>f :setlocal nocursorline <BAR> call RunCurrentFunction() <BAR> setlocal cursorline<CR>
nnoremap <silent> <Leader>e :setlocal nocursorline <BAR> call RunCurrentLine() <BAR> setlocal cursorline<CR>
nnoremap <silent> <Leader>o :call OpenCurrentTest()<CR>

function! RunCurrentLine()
  exec '!php -r "var_dump(' . substitute(getline('.'), '^\s\+\|;$', '', 'g') . ');"'
endfunction

function! RunLastTest()
  if exists("g:php_pushups_last_command")
    exec g:php_pushups_last_command
  else
    echo 'sorry, nothing to run :-('
  end
endfunction

function! RunCurrentFunction()
  let l:current_file=expand('%:p')
  if match(l:current_file, 'Test\.php$') != -1
    let l:function_pattern='\C^\s*\%(public\s\+\|static\s\+\|abstract\s\+\|protected\s\+\|private\s\+\)*function\s\+\([^(]\+\)\s*(.*$'
    let l:function_line=search(l:function_pattern, 'bcnW')
    if l:function_line > 0
      let l:matches=matchlist(getline(l:function_line), l:function_pattern)
      let g:php_pushups_last_command='!vendor/bin/phpunit --filter="' . l:matches[1] . '$" ' . l:current_file
      exec g:php_pushups_last_command
    else
      echo 'sorry, nothing to run :-('
    endif
  elseif match(l:current_file, '\.feature$') != 1
    let l:scenario_pattern='\C^\s*Scenario\s*:\s*.*$'
    let l:scenario_line=search(l:scenario_pattern, 'bcnW')
    if l:scenario_line > 0
      let g:php_pushups_last_command='!cleanup.sh; vendor/bin/behat ' . l:current_file . ':' . l:scenario_line
      exec g:php_pushups_last_command
    else
      echo 'sorry, nothing to run :-('
    endif
  endif
endfunction

function! RunCurrentTest(parameters)
  let l:current_file=expand('%:p')
  let l:test_file='nothing'
  if match(l:current_file, '\.php$') != -1
    if match(l:current_file, 'Test\.php$') != -1
      let l:test_file=l:current_file
    else
      let l:test_file=SearchForRelatedTestFile(l:current_file)
    endif
    if l:test_file != 'nothing'
      let g:php_pushups_last_command='!vendor/bin/phpunit ' . a:parameters. ' ' . l:test_file
      exec g:php_pushups_last_command
    else
      echo 'sorry, nothing to run :-('
    endif
  elseif match(l:current_file, '\.feature$') != 1
    let g:php_pushups_last_command='!cleanup.sh; ./scripts/behat-parallel.sh -q ' . l:current_file
    exec g:php_pushups_last_command
  endif
endfunction

function! OpenCurrentTest()
  let l:current_file=expand("%:p")
  let l:test_file="nothing"
  let l:test_file=SearchForRelatedTestFile(l:current_file)
  if l:test_file != "nothing"
    exec ":belowright :split " l:test_file
  else
    echo "sorry, nothing to open :-("
  endif
endfunction

" REPLACE ARRAY() WITH []
nnoremap <silent> <Leader>a /\<array\>\s*(<CR>:nohl<CR>dwmp%r]`pr[
