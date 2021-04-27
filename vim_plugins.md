Plugins in my .vimrc
====================

Every below plugin is loaded thanks to [Vundle](https://github.com/VundleVim/Vundle.vim)

Ctrlp:
a file finder.
Press <F5> to purge the cache
Press <c-f> and <c-b> to cycle between modes `files` or `buffer`
Press <c-r> to switch to regexp mode
Press <c-j> <c-k> to navigate up and down in the research
Press <c-t> to open in a new tab
Press <c-v> to split vertically and open the file
Press <c-x> to split vertically and open the file

Vim fugitive:
a plugin that empowers you to manage many git commands from Vim.

Vim local vimrc:
searches for local vimrc files in the file system tree of the currently opened file.

Nerdtree:
The NERDTree is a file system explorer for the Vim editor. Using this plugin, 
users can visually browse complex directory hierarchies, quickly open files 
for reading or editing, and perform basic file system operations.

Syntastic:
is a syntax checking plugin
In the vimrc
let g:syntastic_php_checkers=['php']
let g:syntastic_javascript_checkers = ['jshint']

Addon-mw-utils:
cached file contents. Get some information from files and cache the result. 
Dependency of Snipmate

T-lib:
provides some utility functions. Dependency of Snipmate

Snipmate:
Snipmate aims to provide support for textual snippets
Searches in ~/.vim/snippets/filename.snippets
Parser version forced to 1
let g:snipMate = { 'snippet_version' : 1 }

Airline:
When the plugin is correctly loaded, Vim will draw a nice statusline at 
the bottom of each window.

Paredit:
a special editing mode that keeps all matched characters
(parentheses, square and curly braces, double quotes).
Paredit mode is set by default for .lisp, .cl, .clj, cljs, .scm and .rkt files,
but it is possible to switch it off by putting the following statement in the
.vimrc file: let g:paredit_mode = 0

Vim-terraform-completion:
plugin to for Terraform syntax checking and linter

Javascript linter:
needs eslint to be installed (npm install -g eslint)

Vim surround:
Plugin for deleting, changing, and adding "surroundings"

Vim instant markdown:
needs nodejs and `instant-markdown-d` `instant-markdown-d@next` installed globally.
Will allow to instantly preview finicky markdown files in a browser.

Pear tree:
automatically pairs parentheses, quotes, HTML tags, and many other text items based 
on a simple-to-define set of rules. It also provides pair-wise deletion, newline expansion, 
and other typical auto-pair features without interfering with Vim's undo or dot-repeat functionality.

Rainbow Parentheses Improved:
help you read complex code by showing diff level of parentheses in diff color.

Vim test:
A Vim wrapper for running tests on different granularities.
