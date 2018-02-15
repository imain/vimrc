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
  call dein#add('flazz/vim-colorschemes')
  call dein#add('kassio/neoterm')
  call dein#add('fatih/vim-go')

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

let g:deoplete#enable_at_startup = 1
let g:deol#prompt_pattern = '% \|%$'
let mapleader = " "
let g:mapleader = " "

let g:airline_theme='minimalist'
" airline does this for us.
set noshowmode

nnoremap <leader>r :<C-u>Denite -mode=normal -buffer-name=mru file_mru<cr>
nnoremap <leader>y :<C-u>Denite -mode=normal -buffer-name=yank neoyank<cr>
nnoremap <leader>o :<C-u>Denite -mode=normal -buffer-name=outline outline<cr>
nnoremap <leader>b :<C-u>Denite -mode=normal buffer<cr>
nnoremap <leader>q :<C-u>Denite -mode=normal -buffer-name=quickfix-list -no-quit quickfix<cr>
nnoremap <leader>ql :<C-u>Denite -mode=normal -buffer-name=location-list -no-quit location_list<cr>

nmap <leader>gl :<C-u>Denite -mode=normal -buffer-name=git-log gitlog<cr>
nmap <leader>gs :<C-u>Denite -mode=normal -buffer-name=git-status gitstatus<cr>
nmap <leader>gc :<C-u>Denite -mode=normal -buffer-name=git-changed gitchanged<cr>

" Start in insert mode in terminal.
autocmd BufWinEnter,WinEnter term://* startinsert
nmap <leader>v :terminal<cr>

" Trying out netrw file explorer settings.
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
nmap <leader>f :Vexplore<cr>

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

