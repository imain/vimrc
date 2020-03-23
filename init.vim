" NeoVIM configuration file.  Just getting going with it..
" ~/.config/nvim/init.vim
"
" Install:
"
" mkdir -p ~/.config/nvim
" cp init.vim ~/.config/nvim/
" mkdir -p ~/.nvim/repos/github.com/Shougo
" cd ~/.nvim/repos/github.com/Shougo
" git clone https://github.com/Shougo/dein.vim.git

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/imain/.nvim/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/imain/.nvim/')
  call dein#begin('/home/imain/.nvim/')

  " Let dein manage dein
  " Required:
  call dein#add('/home/imain/.nvim/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/deol.nvim')
  call dein#add('Shougo/deoplete-zsh')
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('chemzqm/vim-easygit')
  call dein#add('neoclide/denite-git')
  call dein#add('zchee/deoplete-zsh')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('Shougo/neoyank.vim')
  call dein#add('Shougo/unite-outline')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('imain/awesome-vim-colorschemes')
  call dein#add('kassio/neoterm')
  call dein#add('fatih/vim-go')
  call dein#add('nathanaelkane/vim-indent-guides.git')
  call dein#add('zenbro/mirror.vim')
  call dein#add('hdima/python-syntax')
  call dein#add('vim-scripts/indentpython.vim')
  call dein#add('scrooloose/syntastic')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable


" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

set t_Co=256
colorscheme highlighter_term

" Python syntax stuff
let python_highlight_all = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:deoplete#enable_at_startup = 1
let g:go_version_warning = 0
let g:deol#prompt_pattern = '% \|%$'
let mapleader = " "
let g:mapleader = " "

set completeopt+=longest

" Tab completes..
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

let g:airline_theme='minimalist'
" airline does this for us.
set noshowmode
set expandtab

let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1

hi link IndentGuidesOdd Normal
hi link IndentGuidesEven ColorColumn

hi link EasyMotionTarget ErrorMsg
hi link EasyMotionTarget2First WarningMsg
hi link EasyMotionTarget2Second WarningMsg
hi link EasyMotionShade  Folded

hi link EasyMotionIncSearch ErrorMsg
hi link EasyMotionMoveHL ErrorMsg

nnoremap <leader>b :<C-u>Denite -highlight-window-background=StatusLine -split=floating -buffer-name=buffers -resume buffer<cr>
nnoremap <leader>c :<C-u>Denite -highlight-window-background=StatusLine -split=floating -buffer-name=changes -resume change<cr>
nnoremap <leader>p :<C-u>Denite -highlight-window-background=StatusLine -split=floating -buffer-name=history -resume command_history<cr>
nnoremap <leader>r :<C-u>Denite -highlight-window-background=StatusLine -split=floating -buffer-name=mru -resume file_mru<cr>
nnoremap <leader>y :<C-u>Denite -highlight-window-background=StatusLine -split=floating -buffer-name=yank -resume neoyank<cr>
nnoremap <leader>o :<C-u>Denite -highlight-window-background=StatusLine -split=floating -buffer-name=outline -resume outline<cr>

nmap <leader>gl :<C-u>Denite -buffer-name=git-log gitlog<cr>
nmap <leader>gs :<C-u>Denite -buffer-name=git-status gitstatus<cr>
nmap <leader>gc :<C-u>Denite -buffer-name=git-changed gitchanged<cr>

nmap <leader>v :terminal<cr>

nmap <leader>mp :MirrorPush<cr>

" Trying out netrw file explorer settings.
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
nmap <leader>f :Vexplore<cr>

" Define mappings for denite.
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction


" Allow buffers to be hidden (out of sight while unsaved)
:set hidden

" For terminal so we can escape like normal.
tnoremap <Esc> <C-\><C-n>

" It's easy to never use 'w' these when you have easymotion.
nmap w\ :vsplit<cr>
nmap w- :split<cr>
nmap wj <C-W>j
nmap wk <C-W>k
nmap wh <C-W>h
nmap wl <C-W>l
nmap wc <C-W>c
nmap wd <C-W>c
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
map <leader>u <Plug>(easymotion-s)
map <leader>/ <Plug>(easymotion-sn)

nmap <leader>e 

" Useful mappings for managing tabs
nmap tn :tabnew<cr>
nmap to :tabonly<cr>
nmap tc :tabclose<cr>
nmap td :tabclose<cr>
nmap tp :tabprevious<cr>
nmap tl :tabnext<cr>
nmap th :tabprevious<cr>
nmap tt <C-w>T

let g:lasttab = 1
nmap tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Map alt-# to move to tab, also <leader> #
let c = 1
while c <=9
    exec 'nmap <leader>'.c.' '.c.'gt'
    exec 'nmap t'.c.' '.c.'gt'

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

