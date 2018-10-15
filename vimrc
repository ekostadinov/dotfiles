set encoding=utf-8
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
syntax on
let mapleader = " "
colorscheme pychimp
set hlsearch
set number
set ic " case insensitive search
set incsearch " highlight while search
set smartcase
setlocal foldmethod=syntax " folding enabled
let g:gitgutter_map_keys = 0 " gitgutter no extra mappings

" highlight TODO items
augroup vimrc_todo
    au!
    au Syntax * syn match MyTodo /\v<(FIXME|NOTE|TODO|OPTIMIZE|XXX):/
          \ containedin=.*Comment,vimCommentTitle
augroup END
hi def link MyTodo Todo
highlight MyTodo   ctermfg=magenta guifg=#00ffff

" complete whole lines
:imap <C-l> <C-x><C-l>

" nerdtree
" let NERDTreeIgnore = ['\.pyc$']

" cursor highlighting
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;orange\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  silent !echo -ne "\033]12;red\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal
endif

" Python config
set ts=4
set autoindent
set expandtab
" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
set showmatch
:hi SpecialKey ctermfg=grey guifg=grey70
" set cursorcolumn
" set cursorline
" highlighting all occurences of the word under cursor
:autocmd CursorMoved * exe exists("HlUnderCursor")?HlUnderCursor?printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\')):'match none':""
:let HlUnderCursor=1
" keyword args highlight

" enable all Python syntax highlighting features
let python_highlight_all = 1
" Show trailing whitespace only after some text (ignores blank lines):
" :match /\S\zs\s\+$
:set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
:set list
highlight WhiteSpaceBol ctermbg=darkgrey
" highlight WhiteSpaceMol ctermbg=darkgrey
" match WhiteSpaceMol / /
2match WhiteSpaceBol /^ \+/

" syntastic checks
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" autocomplete python via dictionary
" https://github.com/rkulla/pydiction to add more dictionaries
filetype plugin on
let g:pydiction_location = '~/.vim/pydiction/complete-dict'
let g:pydiction_menu_height = 3

" ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 'et'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" switch buffers via Tab
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>

" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Do not lint or fix minified files.
let g:ale_pattern_options = {
\ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
\ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
\}
" If you configure g:ale_pattern_options outside of vimrc, you need this.
let g:ale_pattern_options_enabled = 1

" netrw
nmap = :Vex<CR>
let g:netrw_list_hide= '.*\.swp$,.*\.pyc'
let g:netrw_hide = 1
let g:netrw_liststyle= 3

" NERDTree
" autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" nnoremap <F4> :NERDTreeToggle<CR>
" let NERDTreeShowHidden=1

" powerline
let g:Powerline_symbols = 'fancy'
set nocompatible " use vim defaults
filetype off " filetype needs to be off before Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin('~/.vim/bundle/')

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'Chiel92/vim-autoformat'
Plugin 'lifepillar/vim-solarized8'
" Plugin 'scrooloose/nerdtree'
Plugin 'powerline/powerline'
Plugin 'airblade/vim-gitgutter'
Plugin 'greggroth/vim-cucumber-folding'

" alternatively, pass a path where Vundle should install plugins
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

