
" To install copy this to your ~/.vimrc and run:
"
" mkdir ~/.vim
" cd ~/.vim
" git clone https://github.com/Shougo/neobundle.vim.git
"
" and then start vim.  Hit yes to the bundle prompt and it will
" download and install all the plugins required.

" Don't load all this stuff if you're using vim-tiny or vim-small.
if !1 | finish | endif


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
NeoBundle 'Shougo/neoyank.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'vim-scripts/ShowTrailingWhitespace'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'nathanaelkane/vim-indent-guides.git'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'hdima/python-syntax'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" Custom prompt for vimshell
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_prompt =  '$ '
let g:vimshell_vimshrc_path = '/home/imain/dot/vimshrc'
let g:vimfiler_as_default_explorer = 1
" Open all files if you press enter on them.
let g:vimfiler_execute_file_list = {}
let g:vimfiler_execute_file_list['_'] = 'vim'
" Start neocomplcache on startup.
"let g:acp_enableAtStartup = 1
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_skip_auto_completion_time=3
let g:neocomplcache_enable_debug=1

" Don't let gitgutter run eagerly (whatever that means)
" Apparently it then only runs on buffer load/save.
let g:gitgutter_eager = 0


" Don't set indent guide colors, we set them below
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1

hi link GitGutterAdd DiffAdd
hi link GitGutterChange DiffChange
hi link GitGutterDelete DiffDelete
hi link GitGutterChangeDelete DiffText

hi link IndentGuidesOdd Normal
hi link IndentGuidesEven ColorColumn


" Select the next longest common string during autocomplete
set completeopt+=longest

" Manually complete with ctrl-l
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

" Set up ctrl-r to be like bash ctrl-r
autocmd FileType vimshell imap <buffer> <C-r>   <Plug>(vimshell_history_unite)
autocmd FileType vimshell imap <buffer> <C-d>   exit<CR>
" Up key to look through history.
autocmd Filetype vimshell inoremap <buffer> <expr> <silent> <Up> unite#sources#vimshell_history#start_complete(!0)
autocmd FileType vimshell imap <buffer> <C-l> <ESC><Plug>(vimshell_clear)i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=1000

" Tell vim to look for tags in updirs until $HOME.
set tags=./tags,tags;$HOME

autocmd BufWritePost *.[ch] :call vimproc#system_bg("/bin/ctags -R")

" Set to auto read when a file is changed from the outside
set autoread

" Show leader in buffer status.
set showcmd

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

" Don't have key sequences timeout.
"set notimeout

" Set 10 lines to the cursor - keeps a good amount of text between
" cursor and bottom/top of window.
set so=10

" Show line breaks instead of going off the end of the terminal.
set linebreak

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
    colorscheme colorful_modified
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Persistent undo!!
set undodir=~/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up some indents for different file types.

" Defaults..
set shiftwidth=4
set tabstop=4
" Use spaces instead of tabs by default.
set expandtab
set smarttab
" Sets linebreak, kinda ugly actually.
"set linebreak

" Settings for specific file types.
autocmd FileType go setlocal shiftwidth=8
autocmd FileType *.c,*.h setlocal shiftwidth=4
autocmd FileType make setlocal noexpandtab shiftwidth=8
" pep8 for our projects want 79 chars max.
autocmd FileType python setlocal shiftwidth=4 textwidth=79
autocmd FileType ruby setlocal shiftwidth=4
autocmd FileType text setlocal textwidth=79
autocmd FileType gitcommit setlocal textwidth=71
" Turn off whitespace for unite buffers or it looks messy
autocmd FileType unite call ShowTrailingWhitespace#Set(0,0)
autocmd FileType vimshell call ShowTrailingWhitespace#Set(0,0)
autocmd FileType yaml setlocal shiftwidth=2

" Turn on auto text wrapping.
set formatoptions+=t

" This should now only apply to C files..
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


map j gj
map k gk

" An alternative to pgup/down
map S 15j
map W 15k

map <PageUp> <C-U>
map <PageDown> <C-D>
imap <PageUp> <C-O><C-U>
imap <PageDown> <C-O><C-D>

" Try to keep the cursor at the same column when using page up/down
set nostartofline

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <c-space> ?

" UNITE
let g:unite_winheight = 20
let g:unite_winwidth = 60
"let g:unite_enable_short_source_names = 1

" disable gitgutter keys
let g:gitgutter_map_keys = 0

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
nmap wj <C-W>j
nmap wk <C-W>k
nmap wh <C-W>h
nmap wl <C-W>l
nmap wc <C-W>c
nmap wo <C-W>o
nmap w<Up> :res +5<cr>
nmap w<Down> :res +5<cr>
nmap WK :res -5<cr>
nmap WJ :res +5<cr>
nmap WH 5<C-W><
nmap WL 5<C-W>>
nmap wK :res -5<cr>
nmap wJ :res +5<cr>
nmap wH 5<C-W><
nmap wL 5<C-W>>
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)
map <leader>h <Plug>(easymotion-linebackward)
map <leader>l <Plug>(easymotion-lineforward)

nmap <leader>\ :vsplit<cr>
nmap <leader>- :split<cr>

nmap <leader>gj :GitGutterNextHunk<cr>
nmap <leader>gk :GitGutterPrevHunk<cr>

nmap <leader>x :FixWhitespace<cr>
nnoremap <leader>f :VimFilerBufferDir<cr>

map <leader>C :TComment<cr>
map <leader>B :TCommentBlock<cr>

"nnoremap <leader>g :<C-u>Unite -no-split -buffer-name=files -start-insert file_rec/async:!<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru file_mru<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank history/yank<cr>
nnoremap <leader>o :<C-u>Unite -buffer-name=outline outline -start-insert<cr>
nnoremap <leader>n :<C-u>Unite -buffer-name=tags tag -start-insert<cr>
nnoremap <leader>b :<C-u>Unite -hide-source-names -update-time=1 buffer<cr>

"nnoremap <silent> <leader>b :<C-u>BufferGatorToggle<cr>

nnoremap <leader>z :<C-u>Unite grep:.: <cr>

" Switch to last used buffer.
nmap <leader>e 
nmap <leader>u :Tagbar<cr>
" Useful mappings for managing tabs
nmap <leader>tn :tabnew<cr>
nmap <leader>to :tabonly<cr>
nmap <leader>tc :tabclose<cr>
nmap <leader>td :tabclose<cr>
nmap <leader>tp :tabprevious
nmap <leader>tl :tabnext
nmap <leader>th :tabmove
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

" close a buffer without closing the window or tab.
nmap <leader>d :Bclose<cr>
nmap <leader>qa :qa<cr>
nmap <leader>qq :q<cr>

nmap <leader>w :w<cr>
nmap <leader>ww :w<cr>
nmap <leader>wq :wq<cr>

" Toggle paste mode on and off
nmap <leader>pp :setlocal paste!<cr>
" Copy to/from clipboard.  This uses ctrl-c/ctrl-v c/v bindings
nmap <leader>pP "+P
nmap <leader>pv "+p
vmap <leader>pc "+y
vmap <leader>py "+y

" Execute(interpret) contents of buffer.
nmap <leader>i :%y"<cr>:@"<cr>

nmap <Enter> zO10jzt

nmap zs :set foldmethod=syntax<cr>:set foldnestmax=1<cr>

" Start a new vimshell
nmap <leader>v :VimShellBufferDir<cr>

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
if exists('g:loaded_fugitive')
  set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l,%c\ %#warningmsg#\ %{fugitive#statusline()}\ %{SyntasticStatuslineFlag()}
endif

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

" Insert blank lines above/below cursor with C-j C-k
nnoremap <silent><C-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><C-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

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

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

" Finally, source vimrc local at the end,  This will let you override stuff
" if you like.
if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif


