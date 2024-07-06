"TAB key option
set smarttab
set tabstop=4
set softtabstop=4 "available for backspace
set shiftwidth=4 
set expandtab "to expand all TABs as SPACEs

" set mapleader
let mapleader = ","
let g:mapleader = ","

"filetype, 'indent on' is necessary for smartindent
filetype plugin on
filetype indent on

"indent
set smartindent
set autoindent

	"Fold method
set foldmethod=marker 

"VIM启动/切换窗口焦点/离开编辑模式时,禁用输入法
autocmd VimEnter,FocusLost * set imdisable
"获得焦点/进入编辑模式时,启用输入法
autocmd FocusGained,InsertEnter * set noimdisable
"to last line when open file
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
" General {{{
set nocompatible
syntax on
syntax enable
"syntax match
set showmatch
set matchtime=2
colorscheme desert
"language
set fileencodings=utf-8,ucs-bom,,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set wrap
set textwidth=0
set modifiable
"No automatic backup files
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set noundofile
set nobackup
set noswapfile
set history=1024
set autochdir
set whichwrap=b,s,<,>,[,]
set nobomb
set backspace=indent,eol,start whichwrap+=<,>,[,]
" Vim 的默认寄存器和系统剪贴板共享
set clipboard+=unnamed
" 设置 alt 键不映射到菜单栏
set winaltkeys=no
"confirm for the readonly/unsaved files when exit
set confirm
"command
set cmdheight=2
set laststatus=2

"search option
set hlsearch
set incsearch 
set ignorecase
set number 
"cursor state
set ruler
"the edge off the buffer
set scrolloff=3
"enable the backspace deletion space up to 2 lines
set backspace=2" }}}
" GUI {{{
set cursorline
set hlsearch
set number
" 窗口大小
set lines=40 columns=135
" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
"不显示工具/菜单栏
set guioptions-=T
set guioptions-=m
set guioptions-=L
set guioptions-=r
set guioptions-=b
" 使用内置 tab 样式而不是 gui
set guioptions-=e
set nolist
set guifont=consolas:h11:cANSI:qDRAFT
function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
set guitablabel=%{ShortTabLabel()}
" }}}"
" Keymap {{{
inoremap jj  <esc>
map <leader>n :tabnew<CR>
map <leader>c :tabclose<cr>
map <leader>h :tabp<cr>
map <leader>l :tabn<cr>
 
" 移动分割窗口
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l
 
" 正常模式下 alt+j,k,h,l 调整分割窗口大小
nnoremap <M-j> :resize +5<cr>
nnoremap <M-k> :resize -5<cr>
nnoremap <M-h> :vertical resize -5<cr>
nnoremap <M-l> :vertical resize +5<cr>
 
" 插入模式移动光标 alt + 方向键
inoremap <M-j> <Down>
inoremap <M-k> <Up>
inoremap <M-h> <left>
inoremap <M-l> <Right>
 
" IDE like delete
inoremap <C-BS> <Esc>bdei
 
nnoremap vv ^vg_
" 转换当前行为大写
inoremap <C-u> <esc>mzgUiw`za
" 命令模式下的行首尾
cnoremap <C-a> <home>
cnoremap <C-e> <end>

vnoremap <BS> d
vnoremap <C-C> "+y
imap <C-v>		<C-R>+
cmap <S-Insert>		<C-R>+
map <leader>ex :!start explorer %:p:h<CR>
inoremap <C-s> <esc>:w<CR>
" 打印当前时间
map <F3> a<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
 
" 复制当前文件/路径到剪贴板
nmap ,fn :let @*=substitute(expand("%"), "/", "\\", "g")<CR>
nmap ,fp :let @*=substitute(expand("%:p"), "/", "\\", "g")<CR>
 
" 设置切换Buffer快捷键"
nnoremap <C-left> :bn<CR>
nnoremap <C-right> :bp<CR>
"Find a selected string area similar with searching word
vnoremap  *  y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
vnoremap  #  y?<C-R>=escape(@", '\\/.*$^~[]')<CR><CR> 
" }}}


" this abbreviation %% expands to the full path of the directory that contains
" the current file. For example, while editing file /some/path/myfile.txt,
" typing: e %%/ on the command line will expand to :e /some/path/.
cabbr <expr> %% expand('%:p:h') 

" 加载Vim自带的插件和相应的语法和文本类型的相关脚本
filetype plugin indent on
 " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
filetype plugin indent on


set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

