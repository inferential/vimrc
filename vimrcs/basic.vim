"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Amir Salihefendic - @amix3k
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Sections:
"    -> General
"    -> Plugins
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

set numberwidth=6
" Column indicating 100 characters
set colorcolumn=100

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

""" Highlight on hover 
set updatetime=1000
autocmd CursorMoved * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
autocmd CursorHold,CursorHoldI * match none
""" Highlight on hover 


" Omnicomplete
set omnifunc=syntaxcomplete#Complete

" Replace all instances selected in Visual mode, using Ctrl+r
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if !filereadable(expand("~/.vim/autoload/plug.vim"))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin("~/.vim/plugged")
    Plug 'ap/vim-css-color'
    Plug 'joshdick/onedark.vim'
    Plug 'lunacookies/vim-colors-xcode'
    Plug 'machakann/vim-highlightedyank'
    Plug 'tpope/vim-surround' 
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-flagship'
    Plug 'tpope/vim-jdaddy' " `aj` provides a text object for the outermost JSON object, array, string, number, or keyword. `gqaj` pretty prints (wraps/indents/sorts keys/otherwise cleans up) the JSON construct under the cursor. `gwaj` takes the JSON object on the clipboard and extends it into the JSON object under the cursor.
    Plug 'preservim/nerdtree'
    Plug 'preservim/tagbar'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'ervandew/supertab'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']} " see: https://github.com/iamcco/markdown-preview.nvim/issues/50
    Plug 'wolandark/vim-piper'
    "" Clojure setup
    Plug 'tpope/vim-fireplace' " Clojure support and REPL integration
    Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file, buffer, mru, tag, etc finder. 
    Plug 'guns/vim-sexp',    {'for': 'clojure'} " Required
    Plug 'liquidz/vim-iced', {'for': 'clojure'} " Required 
    Plug 'liquidz/vim-iced-asyncomplete', {'for': 'clojure'} " Autocomplete for vim-iced
    ""
    call plug#end()

""" vim-flagship
set laststatus=2
set showtabline=2
set guioptions-=e
""" vim-flagship

""" NERDTree
" Start NERDTree and put the cursor back in the other window.
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" autocmd VimEnter * NERDTree | wincmd p
let g:NERDTreeFileLines = 1
"""

""" tagbar
nmap <F8> :TagbarToggle<CR>
" https://github.com/preservim/tagbar/blob/d55d454bd3d5b027ebf0e8c75b8f88e4eddad8d8/doc/tagbar.txt#L512
let g:tagbar_left = 1
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 0 " If you set this option the cursor will move to the Tagbar window when it is opened
let g:tagbar_compact = 1 " 0: Show short help and blank lines between top-level scopes
                         " 1: Don't show the short help or the blank lines.
                         " 2: Don't show the short help but show the blank lines.
let g:tagbar_show_data_type = 1
let g:tagbar_show_linenumbers = 1
let g:tagbar_iconchars = ['▶', '▼']  " (default on Linux and Mac OS X)
" let g:tagbar_iconchars = ['▸', '▾']
" let g:tagbar_iconchars = ['▷', '◢']
autocmd BufEnter * nested :call tagbar#autoopen(0)
"""

""" vim-lsp configuration
let g:asyncomplete_auto_popup = 1
inoremap <silent><expr> <C-Space> asyncomplete#force_refresh()
inoremap <silent><expr> <C-n> pumvisible() ? "\<C-n>" : asyncomplete#force_refresh()
inoremap <silent><expr> <C-p> pumvisible() ? "\<C-p>" : asyncomplete#force_refresh()
let g:lsp_diagnostics_echo_cursor = 1
""" vim-lsp configuration

" Shift+k to display function documentation
" nnoremap <S-k> :LspHover<CR>
nmap gh :LspHover<CR>

" <Tab> for completion
let g:SuperTabDefaultCompletionType = "<c-n>"

"Plug 'wolandark/vim-piper'"" piper TTS
let g:piper_bin = 'piperTTS'
let g:piper_voice = '/usr/share/piper-voices/alba.onnx'
nnoremap tw :call SpeakWord()
nnoremap tc :call SpeakCurrentLine()
nnoremap tp :call SpeakCurrentParagraph()
nnoremap tf :call SpeakCurrentFile()
vnoremap tv :call SpeakVisualSelection()
"""

" Elixir setup
autocmd BufWritePre *.ex,*.exs execute "!mix format %"

"" Deno setup
if executable('deno')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'deno',
    \ 'cmd': {server_info->['deno', 'lsp']},
    \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
    \ 'allowlist': ['typescript', 'typescript.tsx', 'typescriptreact', 'javascript', 'javascript.jsx', 'javascriptreact'],
    \ 'initialization_options': {
    \   'enable': v:true,
    \   'lint': v:true,
    \   'unstable': v:true,
    \   'importMap': 'import_map.json',
    \ },
    \ })
  let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'eslint-language-server', 'deno']
endif
" LSP Keybindings
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gD :LspDeclaration<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <silent> gi :LspImplementation<CR>
nnoremap <silent> <leader>rn :LspRename<CR>
" nnoremap <silent> <leader>f :LspDocumentFormat<CR>
let g:lsp_format_sync_timeout = 1000
autocmd! BufWritePre *.ts,*.js call execute('LspDocumentFormatSync')
" Asyncomplete setup
let g:asyncomplete_auto_completeopt = 0
set completeopt=menuone,noinsert,noselect,preview
" Optional: Close preview window after completion
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" Ultisnips
inoremap <silent><expr> <Tab> pumvisible()
  \ ? UltiSnips#CanExpandSnippet() ? "\<C-r>=UltiSnips#ExpandSnippet()<CR>" : "\<C-y>"
  \ : "\<Tab>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:markdown_fenced_languages = ['ts=typescript'] " https://mattn.github.io/vim-lsp-settings/
"" Deno setup

"" Vim-iced
let g:iced_enable_default_key_mappings = v:true
"" Vim-iced 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Indentation guide
set cursorcolumn
set cursorline

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
" set foldcolumn=1

" Relative numbers
set relativenumber

" Highlight line
set cursorline 

" Copy to clipboard (macOS)
if has('macunix')
    set clipboard=unnamed
elseif has('unix')
    set clipboard=unnamedplus
endif

" Mouse
set mouse=a

" Code folding
" set foldmethod=indent " choices are: manual|indent|syntax|marker|expr
set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()

" Automatic bracket close
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colours and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set regular expression engine automatically
set regexpengine=0

" Enable 256 colour palette in Gnome Terminal
set tabline=

if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" 256 colour support for Vim in tmux
if exists("$TMUX")
        set t_Co=256
        set notermguicolors
elseif has("termguicolors")
        set termguicolors
endif

" colorscheme xcodedark " xcodehc
""" onedark
set background=dark
let g:onedark_termcolors=256
" !Before colorscheme onedark!
let g:onedark_color_overrides = {
            \ "gutter_fg_grey": {"gui": "#BEBEBE" , "cterm": "NONE" , "cterm16": "NONE"}, 
            \ "comment_grey": {"gui": "#808080" , "cterm": "NONE" , "cterm16": "NONE"},
            \}

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
let g:airline_theme='onedark'
colorscheme onedark
""" onedark

""" Set extra options when running in GUI mode
" if has("gui_running")
"     set guioptions-=T
"     set guioptions-=e
"     set t_Co=256
"     set guitablabel=%M\ %t
" endif
""" Set extra options when running in GUI mode

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Current mode
let g:currentmode={
    \ 'n'  : 'NORMAL',
    \ 'no' : 'NORMAL,OP',
    \ 'v'  : 'VISUAL',
    \ 'V'  : 'V-LINE',
    \ '^V' : 'V-BLOCK',
    \ 's'  : 'SELECT',
    \ 'S'  : 'S-LINE',
    \ '^S' : 'S-BLOCK',
    \ 'i'  : 'INSERT',
    \ 'R'  : 'REPLACE',
    \ 'Rv' : 'V-REPLACE',
    \ 'c'  : 'COMMAND',
    \ 'cv' : 'VIM EX',
    \ 'ce' : 'EX',
    \ 'r'  : 'PROMPT',
    \ 'rm' : 'MORE',
    \ 'r?' : 'CONFIRM',
    \ '!'  : 'SHELL',
    \ 't'  : 'TERMINAL'
    \}

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set statusline+=\ %{g:currentmode[mode()]}\  " The current mode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Spell dict 
set spell spelllang=en_gb

" Enable spell checking
set spell

" Spelling mistakes will be colored up red.
hi SpellBad cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellLocal cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellRare cterm=underline ctermfg=203 guifg=#ff5f5f
hi SpellCap cterm=underline ctermfg=203 guifg=#ff5f5f

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Indicate insert mode
autocmd InsertEnter,InsertLeave * set cul!

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
