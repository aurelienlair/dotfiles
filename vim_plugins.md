Plugins in my .vimrc
====================

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

Airline:
When the plugin is correctly loaded, Vim will draw a nice statusline at 
the bottom of each window.

Paredit:
a special editing mode that keeps all matched characters
(parentheses, square and curly braces, double quotes).
Paredit mode is set by default for .lisp, .cl, .clj, cljs, .scm and .rkt files,
but it is possible to switch it off by putting the following statement in the
.vimrc file: let g:paredit_mode = 0
