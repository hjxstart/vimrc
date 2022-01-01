let mapleader=" "
syntax on

"显示行号
set number

"显示鼠标线
set cursorline
"字体不会超出视野
set wrap
"在底线显示当前命令
set showcmd
"命令提示
set wildmenu

"兼容vi
set nocompatible
"识别不同的文件模式
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
"编辑器可以使用鼠标
"set mouse=a
"set encoding=utf-8
"兼容终端配色问题
"let &t_ut=''
"缩进
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
"行尾
"set list
"保持预览在上下5行之间
set scrolloff=5
"退格键可以回到行首
set backspace=indent,eol,start
"收起代码
set foldmethod=indent
set foldlevel=99
"底下状态栏等于2
set laststatus=2
set autochdir
"重新打开文件光标会显示上一次打开的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"1. noremap a b | 改键位,a 键 替换 b键盘
"加快上下左右浏览的速度
noremap J 5j
noremap K 5k
noremap H 5h
noremap L 5l

"查看上/下一个搜索接口并显示在中间
noremap n nzz
noremap n nzz
"空格回车:去除搜索高亮
noremap <leader><cr> :nohlsearch<cr>

"搜索高亮
set hlsearch
"重新打开文件不会显示搜索高亮
exec "nohlsearch"
set incsearch
"忽略大小写
set ignorecase
"智能大小写
set smartcase

"2. map s :w<cr> | 快捷键
map s <nop>
"保存
map S :w<cr>
"退出
map Q :q<cr>
"更新配置文件
map R :source $MYVIMRC<cr>
"3. <operation> <motion>
"x : 删除当前字符
"d + 方向键 + number 删除方向上的 number 个字符
"y + 方向键 + number 复制方向上的 number 个字符
"c + 方向键 + number 删除并进入写入模式
"w : 移动一个词。
"ciw : 修改当前词；ci" : 将"符号内的词全部修改；
"yi" : 将"符号内的词全部复制; di" : 将"符号内的词全部删除。
"f" : 查找下一个"符号。
"df" : 删除到下一个"符号的内容；yf" : 复制到下一个"符号的内容；
"cf" : 删除到下一个"符号的内容并进入写入模式
"zz : 将当前行显示在中间 

"4. :命令模式
"split : 上下分屏；vsplit : 左右分屏
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sl :set splitright<CR>:vsplit<CR>
"7. ctrl + w + 方向 : 分屏间光标切换
"空格 + 方向 : 来切切换屏幕
"上下左右屏幕切换
map <LEADER>k <C-w>k
map <LEADER>j <C-w>j
map <LEADER>h <C-w>h
map <LEADER>l <C-w>l
"8. :vertical resize-5 设置当前分屏大小
map wk :res +5<CR>
map wj :res -5<CR>
map wh :vertical resize-5<CR>
map wl :vertical resize+5<CR>
"9. :tabe 打开新的标签
map tt :tabe<CR>
"切换标签页
map tl :+tabnext<CR>
map th :-tabnext<CR>

"6. 打开文件
":e path : 打开路径下的文件

"5. v 模式：鼠标单击. shift + v : 行模式. 
"control + v : 可视块模式(禅模式); 选择后按 shift + i 修改内容；再esc生效
" v 模式选择后，可以输入:normal I"，进行统一注释


"插件列表
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
"目录树
Plug 'preservim/nerdtree'
"代码提示
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
call plug#end()


"插件配置
"nerdtree
nnoremap  <leader> n :NERDTreeFocus <CR>
nnoremap  <C-n> :NERDTree <CR>
nnoremap  ff :NERDTreeToggle <CR>
nnoremap  <C-f> :NERDTreeFind <CR>

imap <c-j> <Plug>(coc-snippets-expand)
let g:coc_node_path = "/usr/local/bin/node"

"coc.nvim插件列表
let g:coc_global_extensions = [
  \'coc-markdownlint',
  \'coc-git',
  \'coc-emmet',
  \'coc-eslint',
  \'coc-highlight',
  \'coc-html',
  \'coc-json',
  \'coc-snippets',
  \'coc-tsserver',
  \'coc-css',
  \'coc-vetur',
  \'coc-vimlsp',
  \'coc-lists',
  \]

"coc.nvim配置
"设置缓冲区
set hidden
"提高vim反应时间
set updatetime=100
"去掉地下信息栏没用的东西
set shortmess+=c
"tab代码补全
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"使用[g 或者 ]g查看上一个活下一个报错信息
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"跳转代码
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"使用D查看当前变量的文档
nnoremap <silent> D :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
"重命名当前选中变量
nmap <leader>rn <Plug>(coc-rename)
"选中部分代码进行修改

