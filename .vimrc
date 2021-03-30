" GENERAL SETTINGS
set nocompatible 
set fileformat=unix
set encoding=utf-8 
set number
syn on
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
set colorcolumn=80

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
" AUTOCLOSE
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype clojure setlocal ts=2 sw=2 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType js setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType json autocmd BufWritePre <buffer> %!jq '.'

" PLUGGED SETTINGS "
call plug#begin('~/.vim/plugged')
" EDITING
  Plug 'kien/ctrlp.vim'
  Plug 'scrooloose/nerdTree'
  Plug 'vim-scripts/paredit.vim'
  Plug 'tpope/vim-surround'
" TERRAFORM
  Plug 'hashivim/vim-terraform'
  Plug 'juliosueiras/vim-terraform-completion'
" SYNTAX
  Plug 'scrooloose/syntastic'
" UTILS 
  Plug 'tpope/vim-fugitive'
  Plug 'garbas/vim-snipmate'
  Plug 'honza/vim-snippets'
  Plug 'vim-airline/vim-airline'
  Plug 'MarcWeber/vim-addon-mw-utils'
  Plug 'tomtom/tlib_vim'
  Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
" CONFIG
  Plug 'embear/vim-localvimrc'
call plug#end()

" NERDTREE SETTINGS
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
map  <C-y> :tabnew<CR>
map  <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
let NERDTreeShowHidden=1

" CTRLP SETTINGS "
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|work|swp|terraform)|node_modules|vendor$',
    \ 'file': '\v\.(gitmodules|gitignore)|versions.tf$',
    \ } 

" LOCALVIMRC SETTINGS "
let g:localvimrc_sandbox = 0

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
let g:syntastic_sh_checkers = ['shellcheck', 'sh']
let g:syntastic_javascript_checkers = ['eslint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" SNIPMATE PARSER VERSION
let g:snipMate = { 'snippet_version' : 1 }

"enable undo persistence for all but tmp files
set undofile
set undodir=$HOME/.vim/undo
" exlude tmp files
" autocmd BufWritePre /tmp/* setlocal noundofile
" autocmd BufWritePre */.git/COMMIT_EDITMSG setlocal noundofile
