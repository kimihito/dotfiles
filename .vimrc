scriptencoding utf-8
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd

set expandtab
set tabstop=2
set shiftwidth=2
set smarttab
set autoindent
set smartindent
set backspace=indent,eol,start

" <Leader>というプレフィックスキーにスペースを使用する
let g:mapleader = "\<Space>"

" スペース + . でvimrcを開く open .vimrc
nnoremap <Leader>. :new ~/.vimrc<CR>

" スペース + wでファイル保存
nnoremap <Leader>w :w<CR>

if has("autocmd")
  filetype plugin on
  filetype indent on
endif

call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'

if has("mac")
  Plug '/usr/local/opt/fzf'
else
 Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
endif

Plug 'junegunn/fzf.vim'

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'mattn/vim-lsp-icons'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-jp/vimdoc-ja'

Plug 'airblade/vim-rooter'

Plug 'tpope/vim-rails'

call plug#end()

" 行番号を表示
set number
" 現在の行を強調表示
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable

let g:solarized_termcolors=256
set t_Co=256
set background=dark
colorscheme solarized


" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 日本語の行の連結時には空白を入力しない
set formatoptions+=mMj


" fzf.vim
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using Vim function
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --hidden --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

nnoremap [fzf] <Nop>
nmap <Leader>f [fzf]
nnoremap <silent> [fzf]f :Files<CR>
nnoremap <silent> [fzf]r :RG<CR>
nnoremap <silent> [fzf]c :Colors<CR>
nnoremap <silent> [fzf]h :History<CR>
nnoremap <silent> [fzf]b :Buffers<CR>
nnoremap <silent> [fzf]; :Commands<CR>
nnoremap <silent> [fzf]:h :Helptags<CR>
nnoremap <silent> [fzf]ll :Lines<CR>
nnoremap <silent> [fzf]lb :BLines<CR>

" vim-lsp
let g:lsp_signs_enabled = 1 " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_async_completion = 1

if executable('efm-langserver')
  augroup LspEFM
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
     \ 'name': 'efm-langserver',
     \ 'cmd' : {server_info->['efm-langserver', '-c='.$HOME.'/.config/efm-langserver/config.yaml', '-log='.$HOME.'/.config/efm-langserver/logs/efm-langserver.log']},
     \ 'whitelist': ['vim', 'markdown', 'ruby'],
     \ })
    autocmd BufWritePre <buffer> silent! LspDocumentFormatSync
  augroup END
endif

"netrw
let g:netrw_liststyle=1
let g:netrw_banner=0
let g:netrw_preview=1

" vim-better-whitespace
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm = 0

" vim-rooter
let g:rooter_change_directory_for_non_project_files = 'current'
