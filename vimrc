if empty(glob('~/.vim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall
 endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic'

" YouCompleteMe
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --gocode-completer --tern-completer' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" tpope's famous git wrapper
Plug 'tpope/vim-fugitive'

" surround.vim - easily modify surrounding quotes, brackets, parantheses, etc
Plug 'tpope/vim-surround'

" Todo.txt plugin for vim
Plug 'freitass/todo.txt-vim'

" Vim-Airline status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" tmux integration for Airline bar
Plug 'edkolev/tmuxline.vim'

" Undo history visualizer
Plug 'mbbill/undotree'

" Tagbar - a class outline viewer
Plug 'majutsushi/tagbar'

" JS Syntax - REMOVED IN FAVOR OF YAJS (below)
"Plug 'jelera/vim-javascript-syntax'

" YAJS - Yet Another JS Syntax for vim
Plug 'othree/yajs.vim'
" ES7 and future syntax
Plug 'othree/es.next.syntax.vim'

" Syntax for JS Libraries
Plug 'othree/javascript-libraries-syntax.vim'

" JS Functional scope autocomplete
Plug 'othree/jspc.vim'

" Tools for node development
Plug 'moll/vim-node'

" Tern-based JS editing support
Plug 'ternjs/tern_for_vim'

" JS Indenting
Plug 'pangloss/vim-javascript'

" Vim-JSX
Plug 'mxw/vim-jsx'

" Vue component syntax highlighting
Plug 'posva/vim-vue'

" ES2015 code snippets
Plug 'epilande/vim-es2015-snippets'

" React code snippets
Plug 'epilande/vim-react-snippets'

" TypeScript Support
Plug 'clausreinke/typescript-tools.vim', { 'do': 'npm install' } 

" Indent Highlighting
Plug 'nathanaelkane/vim-indent-guides'

" Emmet HTML/CSS toolkit
Plug 'mattn/emmet-vim'

" Auto-close HTML tags
Plug 'alvan/vim-closetag'

" PHP Syntax
Plug 'StanAngeloff/php.vim'

" Add closing character
Plug 'Raimondi/delimitMate'
" Auto Pairs (since I broke delimitMate)
"Plug 'jiangmiao/auto-pairs.git'

" Ctrl+P
Plug 'ctrlpvim/ctrlp.vim'

" filesync
Plug 'cosminadrianpopescu/filesync'

" vim 8 plugins
" codi interactive scratchpad
Plug 'metakirby5/codi.vim'

" Color themes
Plug 'w0ng/vim-hybrid'
Plug 'Lokaltog/vim-distinguished'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'juanedi/predawn.vim'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'joshdick/onedark.vim'  
Plug 'dikiaap/minimalist' 
" Theme pack!
Plug 'flazz/vim-colorschemes' 

" Add plugins to &runtimepath
call plug#end()

" Start Pathogen
execute pathogen#infect()

" Options for tern_for_vim
" enable keyboard shortcuts
let g:tern_map_keys=1
" show argument hints
let g:tern_show_argument_hints='on_hold'

" Closetag file extensions and avoid interference with delimitMate
let g:closetag_filenames = "*.xml,*.html,*.xhtml,*.phtml,*.php,*.js"
au FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = "(:),[:],{:}"

" YCM settings
let g:ycm_autoclose_preview_window_after_completion = 1

" UltiSnips options (including preventing from interfering with YCM)
let g:UltiSnipsExpandTrigger="<c-w>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ultisnipssnippetdirectories=['ultisnips', 'mysnippets']

" declare javascript libraries used for js lib syntax plugin
let g:used_javascript_libs = 'react,jquery,underscore,backbone,vue'

" allow jsx syntax in .js files
let g:jsx_ext_required = 0

" more typescript
"filetype plugin on
au bufread,bufnewfile *.ts    setlocal filetype=typescript
"set rtp+=~/.vim/plugged/typescript-tools.vim/
if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
" Prevent ycm code details preview window
"set completeopt-=preview

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" Additional Syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_go_checkers = ['go', 'golint', 'errcheck'] 

" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn Go highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" Open NERDTree
map <C-n> :NERDTreeToggle<CR>

" KEYBINDINGS
" Map leader key to ,
let mapleader=","
" Re-map esc as fd 
inoremap fd <esc>
" highlight last inserted text
nnoremap gV `[v`]
" Add newline and space (for function) 
imap <C-c> <CR><Esc>O
" Make backspace normal (and not protected)
set backspace=indent,eol,start

" List buffers by number and select one
nnoremap <F5> :buffers<CR>:buffer<Space>

" Highlights parantheses sets
let loaded_matchparen = 1

" Adds for powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
let g:airline_powerline_fonts = 1
" Always open airline bottom bar
set laststatus=2
" Highlights matching parantheses to one under cursor
set showmatch
" vim will hide buffers on switch (instead of forcing :w)
set hidden
" Search as characters are entered
set incsearch
" Highlight search matches
set hlsearch
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" Turn on line numbers
set number
" Set buffer updatetime
autocmd BufEnter * set updatetime=2000

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Make DeliMate auto-indent on return
"let delimitMate_expand_cr = 1
"let delimitMate_expand_space = 1

" Effects for color themes
"let g:wwdc16_term_italics = 1
"let g:wwdc16_term_trans_bg = 1
"let g:hybrid_reduced_contrast = 1

" Make background transparent
"hi Normal ctermbg=none
set t_Co=16
syntax enable
let g:solarized_termtrans = 1
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

