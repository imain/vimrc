
" To install copy this to your ~/.vimrc and run:
"
" mkdir ~/.vim
" cd ~/.vim
" git clone git@github.com:Shougo/neobundle.vim.git
"
" and then start vim.  Hit yes to the bundle prompt and it will
" download and install all the plugins required.

if has('vim_starting')
  set nocompatible               " Be iMproved

" Required:
set runtimepath+=~/.vim/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
        \ 'build' : {
        \     'windows' : 'make -f make_mingw32.mak',
        \     'cygwin' : 'make -f make_cygwin.mak',
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    }
        \ }
NeoBundle 'Shougo/unite-build'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-session'
NeoBundle 'Shougo/neocomplcache.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'jnwhiteh/vim-golang'
NeoBundle 'vim-scripts/ShowTrailingWhitespace'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Lokaltog/vim-easymotion'

"NeoBundle 'flazz/vim-colorschemes'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Golang stuff.. we'll see..
" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
filetype plugin indent on
syntax on

autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Custom prompt for vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '
let g:vimshell_vimshrc_path = '/home/imain/dot/vimshrc'
let g:vimfiler_as_default_explorer = 1


" Start neocomplcache on startup.
"let g:acp_enableAtStartup = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_skip_auto_completion_time=3
let g:neocomplcache_enable_debug=1

" Don't let gitgutter run eagerly (whatever that means)
" Apparently it then only runs on buffer load/save.
let g:gitgutter_eager = 0

" One of these must do what I want..
"let g:neocomplcache_auto_completion_start_length = 5
"let g:neocomplcache_min_syntax_length = 5

let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" Select the next longest common string
set completeopt+=longest

" Manually complete with ctrl-l
"inoremap <expr><C-l>     neocomplcache#start_manual_complete()
" Tab completes..
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
"inoremap <expr><S-TAB>  neocomplcache#start_manual_complete()
"inoremap <expr><TAB>  <C-x><C-u>

" try this one.. tab to open menu if prev char is not a space
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : "\<C-x>\<C-u>"
function! s:check_back_space()"{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction"}}}


" Start a new tab when you use 'vim <filename>' in vimshell
let g:vimshell_split_command='tabnew'

" Set up ctrl-r to be like bash ctrl-r
autocmd FileType vimshell imap <silent> <buffer> <C-r> <Plug>(vimshell_history_unite)

" Don't use ignorecase for autocomplete.
" let g:acp_ignorecaseOption=0

" Set background color for whitespace matching to green.
highlight ShowTrailingWhitespace ctermbg=green guibg=green

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=1000

" Tell vim to look for tags in updirs until $HOME.
set tags=./tags,tags;$HOME

autocmd BufWritePost *.[ch] :call vimproc#system_bg("/bin/ctags -R")

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Show leader in buffer status.
set showcmd

" Set timeoutlen for escape sequences pretty short.  I never use a laggy interface (well almost)
" This is in ms obviously.
:set timeout timeoutlen=1500 ttimeoutlen=150

" With a map leader it's possible to do extra key combinations
nnoremap <SPACE> <Nop>
" This works and let's you see the leader being pressed down below
" but it then turns to a normal space.. so <leader><leader> maps
" don't work right..
"nmap <SPACE> \
let mapleader = " "
let g:mapleader = " "


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set 12 lines to the cursor - keeps a good amount of text between
" cursor and bottom/top of window.
set so=12

" Show line breaks instead of going off the end of the terminal.
set linebreak

" Max width to show.
set textwidth=210

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.lo

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
" set ignorecase

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

set background=dark

" Some gui options
set winaltkeys=no

" Set extra options when running in GUI mode
if has("gui_running")
    "remove menu bar
    set guioptions-=m
    "remove toolbar
    set guioptions-=T
    "remove right-hand scroll bar
    set guioptions-=r
    set guifont=Monospace\ 12

    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    colorscheme shobogenzo
else
    set t_Co=256
    colorscheme shobogenzo_terminal
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Persistent undo!!
set undodir=~/dot/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
" Doing lots of golang lately..
set shiftwidth=8
set tabstop=8

" Linebreak on 500 characters
set lbr
set tw=500

"set ai "Auto indent
"set si "Smart indent
"set wrap "Wrap lines

" C style indent
set cindent

" Set some options.. (0 makes lines on new line line up with open paren.
set cinoptions=(0,W4

" always show tabs
set showtabline=2

" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
    let label = ''
    let bufnrlist = tabpagebuflist(v:lnum)
    " Add '+' if one of the buffers in the tab page is modified
    for bufnr in bufnrlist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor
    " Append the tab number
    let label .= v:lnum.': '
    " Append the buffer name
    let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
    if name == ''
        " give a name to no-name documents
        if &buftype=='quickfix'
            let name = '[Quickfix List]'
        else
            let name = '[No Name]'
        endif
    else
        " get only the file name
        let name = fnamemodify(name,":t")
    endif
    let label .= name
    " Append the number of windows in the tab page
    let wincount = tabpagewinnr(v:lnum, '$')
    return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}

set guitablabel=%N\ %f

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Hate the default locate of pgup/down.  Steel some less used keys..
map S 15j
map W 15k

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <c-space> ?

" UNITE
let g:unite_source_history_yank_enable = 1
let g:unite_winheight = 20
let g:unite_winwidth = 60
let g:unite_enable_short_source_names = 1

" disable gitgutter keys
let g:gitgutter_map_keys = 0

" Try a different sort.. dunno
" call unite#filters#sorter_default#use(['sorter_word'])
call unite#custom#source('buffer', 'sorters', 'sorter_word')

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
  " I think this makes it so that when you hit jj in unite when it's in insert mode it gets
  " out of it.. pretty smart
  imap <buffer> jj      <Plug>(unite_insert_leave)
  nmap <silent><buffer><expr> <C-s>     unite#do_action('split')
  nmap <silent><buffer><expr> s unite#do_action('switch')
  nmap <buffer><expr> s unite#do_action('switch')
  nmap <buffer><expr> p unite#do_action('persist_open')
  nmap <buffer><expr> \ unite#do_action('vsplit')
  nmap <buffer><expr> - unite#do_action('split')
  nnoremap <silent><buffer><expr> o unite#do_action('switch')

endfunction

nmap <C-Up> :res +1<cr>
nmap <C-Down> :res -1<cr>

" Disable highlight when <leader><cr> is pressed
"map <silent> <leader><cr> :noh<cr>

" It's easy to never use 'w' these when you have easymotion.
nmap w\ :vsplit<cr>
nmap w- :split<cr>
nmap wj <C-W>j:res 40<cr>
nmap wk <C-W>k:res 40<cr>
nmap wh <C-W>h
nmap wl <C-W>l
nmap wc <C-W>c
nmap wo <C-W>o

map <leader>j <Plug>(easymotion-f)
map <leader>k <Plug>(easymotion-F)

nmap <leader>\ :vsplit<cr>
nmap <leader>- :split<cr>

nmap <leader>gj :GitGutterNextHunk<cr>
nmap <leader>gk :GitGutterPrevHunk<cr>

nnoremap <leader>f :VimFiler<cr>
"autocmd FileType vimfiler nmap <buffer> <cr> <Plug>(vimfiler_edit_file)

"nnoremap <leader>g :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru file_mru<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>
nnoremap <leader>o :<C-u>Unite -buffer-name=files file_rec/git directory:. directory_mru directory:/home/imain/notes <cr>
nnoremap <silent> <leader>b :<C-u>Unite -hide-source-names -update-time=1 buffer<cr>

"nnoremap <silent> <leader>b :<C-u>BufferGatorToggle<cr>

nnoremap <leader>z :<C-u>Unite grep:.: <cr>

" split to tiled windows
"map <leader>n <Plug>GoldenViewSplit

" Switch to last used buffer.
nmap <leader>e 

nmap <leader>u :Tagbar<cr>
" Useful mappings for managing tabs
nmap <leader>tn :tabnew<cr>
nmap <leader>to :tabonly<cr>
nmap <leader>tc :tabclose<cr>
nmap <leader>td :tabclose<cr>
nmap <leader>tm :tabmove
nmap <leader>tt <C-w>T
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nmap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
nmap <leader>cd :cd %:p:h<cr>:pwd<cr>

" To go to the previous search results do:
"   <leader>p
"
nmap <leader>cc :botright cope<cr>
nmap <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
" Read errorlist from the current buffer.
nmap <leader>cb :cb<cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>
nmap <leader>c :cn<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing this will toggle and untoggle spell checking
nmap <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
nmap <leader>sn ]s
nmap <leader>sp [s
nmap <leader>sa zg
nmap <leader>s? z=

" close a buffer
nmap <leader>d :bd!<cr>
nmap <leader>qa :qa<cr>
nmap <leader>qq :q<cr>

nmap <leader>w :w<cr>
nmap <leader>ww :w<cr>
nmap <leader>wq :wq<cr>

" Toggle paste mode on and off
nmap <leader>pp :setlocal paste!<cr>
" Paste form clipboard
nmap <leader>pc "+p

" Execute(interpret) contents of buffer.
nmap <leader>i :%y"<cr>:@"<cr>

" Start a new vimshell
nmap <leader>v :VimShell<cr>

" Map alt-# to move to tab, also <leader> #
let c = 1
while c <=9
    exec 'nmap <leader>'.c.' '.c.'gt'

    if has("gui_running")
        exec 'nmap <A-'.c.'> '.c.'gt'
        " Map these in input mode too so that we don't hit numbers in
        " command mode.
        exec 'imap <A-'.c.'> <Esc>'.c.'gt'
    else
        exec 'imap '.c '<Esc>'.c.'gt'
        exec 'nmap '.c c.'gt'
    endif
    let c += 1
endwhile

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l,%c\ %#warningmsg#\ %{fugitive#statusline()}\ %{SyntasticStatuslineFlag()}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
"nmap j mz:m+<cr>`z
"nmap k mz:m-2<cr>`z
vmap j :m'>+<cr>`<my`>mzgv`yo`z
vmap k :m'<-2<cr>`>my`<mzgv`yo`z

nmap <A-j> mz:m+<cr>`z
nmap <A-k> mz:m-2<cr>`z
vmap <A-k> :m'<-2<cr>`>my`<mzgv`yo`z
vmap <A-j> :m'>+<cr>`<my`>mzgv`yo`z

" Map alt-hjkl to move in insert mode.
imap <A-h> OD
imap <A-j> OB
imap <A-k> OA
imap <A-l> OC

" Delete trailing white space on save.. optional
func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
" noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
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

