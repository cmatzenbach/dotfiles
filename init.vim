if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	    autocmd VimEnter * PlugInstall
 endif

call plug#begin('$HOME/.config/nvim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'scrooloose/syntastic'

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*', 'do': ':GoInstallBinaries' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Deoplete async code completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } 

" Neomake async :make and linting framework
Plug 'neomake/neomake'

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
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }

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

" Padawan PHP autocompletion server
Plug 'pbogut/deoplete-padawan'

" Add closing character
Plug 'Raimondi/delimitMate'

" Super Tab
Plug 'ervandew/supertab'

" Auto Pairs (since I broke delimitMate)
"Plug 'jiangmiao/auto-pairs.git'

" Ctrl+P
Plug 'ctrlpvim/ctrlp.vim'

" filesync
Plug 'cosminadrianpopescu/filesync'

" Color themes
Plug 'w0ng/vim-hybrid'
Plug 'Lokaltog/vim-distinguished'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'juanedi/predawn.vim'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'joshdick/onedark.vim'  
Plug 'dikiaap/minimalist' 
Plug 'nanotech/jellybeans.vim'
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
let g:tern_show_signature_in_pum = 1
" Map TernDef to gb
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" Closetag file extensions
let g:closetag_filenames = "*.xml,*.html,*.xhtml,*.phtml,*.php,*.js"
" Avoid interference with delimitMate
au FileType xml,html,phtml,php,xhtml,js let b:delimitMate_matchpairs = "(:),[:],{:}"

" Config for padawan php server
let $PATH=$PATH . ':' . expand('~/.config/composer/vendor/bin')
let g:padawan#composer_command = "php /usr/local/bin"

" Start deoplete madness
let g:deoplete#enable_at_startup = 1

"OLD --------
"if !exists('g:deoplete#omni#input_patterns')
"  let g:deoplete#omni#input_patterns = {}
"endif
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"if exists('g:plugs["tern_for_vim"]')
"    let g:tern_show_argument_hints = 'on_hold'
"    let g:tern_show_signature_in_pum = 1

"    autocmd FileType javascript setlocal omnifunc=tern#Complete
"endif
" -------------

" NEW ---------
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
  \ 'tern#Complete',
  \ 'jspc#omni'
\]
set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Make SuperTab use <c-n> autocompletion (top to bottom) instead of <c-p>
let g:SuperTabDefaultCompletionType = "<c-n>"
" close the preview window when you're not using it
let g:SuperTabClosePreviewOnPopupClose = 1
"---------------

" Neomake settings
" automatically run on :w
autocmd! BufWritePost * Neomake
" opens error window when neomake is called
let g:neomake_open_list = 2
let g:neomake_javascript_enabled_makers = ['eslint']
" keybindings
nmap <Leader><Space>o :lopen<CR>" open location window
nmap <Leader><Space>c :lclose<CR>" close location window
nmap <Leader><Space>, :ll<CR>" go to current error/warning
nmap <Leader><Space>n :lnext<CR>" next error/warning
nmap <Leader><Space>p :lprev<CR>" previous error/warning

" YCM settings
"let g:ycm_autoclose_preview_window_afmer_completion = 1

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
"let g:ycm_semantic_triggers['typescript'] = ['.']
" Prevent ycm code details preview window
"set completeopt-=preview

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

" Additional Syntastic settings
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_go_checkers = ['go', 'golint', 'errcheck'] 

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

" Neovim specific mods
" Escape terminal mode
tnoremap <Esc> <C-\><C-n>

" Make DeliMate auto-indent on return
"let delimitMate_expand_cr = 1
"let delimitMate_expand_space = 1

" Effects for color themes
"let g:wwdc16_term_italics = 1
"let g:wwdc16_term_trans_bg = 1
"let g:hybrid_reduced_contrast = 1

" Make background transparent
"hi Normal ctermbg=none
syntax enable
let g:solarized_termtrans = 1
let g:solarized_termcolors=16
set background=dark
colorscheme solarized


