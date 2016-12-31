
syntax on
set tabstop=4
set shiftwidth=4
set nu

au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |


" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


set clipboard=unnamed
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
set encoding=utf-8


" setup for the vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'

Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} "status line, show the filename/git path/ virtual environ
Plugin 'vim-scripts/indentpython.vim' "python code indent
Plugin 'scrooloose/syntastic'   "syntax check
Plugin 'nvie/vim-flake8'		"pep8 syntax check
Plugin 'jnurmine/Zenburn'   "color
Plugin 'altercation/vim-colors-solarized'   "color
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'   " git plugin
Plugin 'bitc/vim-bad-whitespace'    " hightlight the whitespace
Plugin 'davidhalter/jedi-vim'    "coding tips



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" 1, setup for the SimplyFold
let g:SimpylFold_docstring_preview=1


"Enable folding
"set foldmethod=indent
"set foldlevel=99
""Enable folding with the spacebar
nnoremap <space> za


" 2, setup for the YCM
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" 3, syntex check and highlight
let python_highlight_all=1
syntax on


" 4, setup for the color
"if has('gui_running')
"	set background=dark
"	colorscheme solarized
"else
"	colorscheme Zenburn
"endif

"call togglebg#map("<F5>")


" 5, setup for the nerdtree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree



""""""""""""""""""""""     "Quickly Run     """""""""""""""""""""" map
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
       	exec "!time java %<"
   	elseif &filetype == 'sh'
        :!time bash %
   	elseif &filetype == 'python'
       exec "!time python2.7 %"
   	elseif &filetype == 'html'
        exec "!firefox % &"
  	elseif &filetype == 'go'     "
      	exec "!go build %<"
   		exec "!time go run %"
  	elseif &filetype == 'mkd'
    	exec "!~/.vim/markdown.pl % > %.html &"
		exec "!firefox %.html &"
   endif
endfunc

"<f9>  gdb调试
map <f9> :call Debug()<cr>
func!  Debug()
exec "w"
exec "!gcc % -o %< -gstabs+"
exec "!gdb %<"
endfunc


nnoremap <F2> :NERDTreeToggle<CR>



" python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF
