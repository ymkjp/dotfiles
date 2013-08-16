" ========== First to do ==========
"
" :NeoBundleInstall

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ========== General Config =========="{{{
set notitle
set number
set modeline
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" mouse mode ON
set mouse=a
" xterm screen
set ttymouse=xterm2
" マウスの移動でフォーカスを自動的に切替えない (mousefocus:切替る)
set nomousefocus
" 入力時にマウスポインタを隠す (nomousehide:隠さない)
set mousehide

"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"日本語の行の連結時には空白を入力しない。
set formatoptions+=mM
"画面最後の行をできる限り表示する。
set display+=lastline

" ========== Indentation ==========
set autoindent
set smartindent
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=0
set tabstop=4

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ========== Folds ==========
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ========== Turn Off Swap Files ==========
set noswapfile
set nobackup
set nowb

" ========== Persistent Undo ==========
" Keep undo history across sessions, by storing in file.
" Only works all the time.

if v:version >= 703
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile
endif

" ========== Language ==========
" 文字コードの自動認識
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif
if has('iconv')
    let s:enc_euc = 'euc-jp'
    let s:enc_jis = 'iso-2022-jp'
    " iconvがeucJP-msに対応しているかをチェック
    if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'eucjp-ms'
        let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
    elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
        let s:enc_euc = 'euc-jisx0213'
        let s:enc_jis = 'iso-2022-jp-3'
    endif
    " fileencodingsを構築
    if &encoding ==# 'utf-8'
        let s:fileencodings_default = &fileencodings
        let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
        let &fileencodings = &fileencodings .','. s:fileencodings_default
        unlet s:fileencodings_default
    else
        let &fileencodings = &fileencodings .','. s:enc_jis
        set fileencodings+=utf-8,ucs-2le,ucs-2
        if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
            set fileencodings+=cp932
            set fileencodings-=euc-jp
            set fileencodings-=euc-jisx0213
            set fileencodings-=eucjp-ms
            let &encoding = s:enc_euc
            let &fileencoding = s:enc_euc
        else
            let &fileencodings = &fileencodings .','. s:enc_euc
        endif
    endif
    "定数を処分
    unlet s:enc_euc
    unlet s:enc_jis
endif
"日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
    function! AU_ReCheck_FENC()
        if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
            let &fileencoding=&encoding
        endif
    endfunction
    autocmd BufReadPost * call AU_ReCheck_FENC()
endif
"改行コードの自動認識
set fileformats=unix,dos,mac
"□とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
    set ambiwidth=double
endif

" ========== Search Settings ==========
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する(noignorecase)
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する(nosmartcase)
set smartcase
" ハイライトサーチ（Esc連打で取り消し）
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" インクリメンタルサーチ
set incsearch
"検索をファイルの先頭へループしない
set nowrapscan

" ========== Scrolling ==========
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ========== 色の設定 ==========
syntax on
let g:hybrid_use_Xresources = 1
colorscheme hybrid

" 全角スペースを視覚化
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    "autocmd WinLeave * set nocursorcolumn
    autocmd WinEnter,BufRead * set cursorline
    "autocmd WinEnter,BufRead * set cursorcolumn
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

execute "set colorcolumn=" . join(range(81, 9999), ',')

" ========== MAPS ==========
" ;でコマンド入力
noremap ; :

" ========== Abbreviations ==========
ab #l ----------
ab #L ==========

"}}}

" ========== PLUGINS ========== {{{
"
if filereadable(expand('~/.vimrc.plugin')) && v:version >= 703
    source ~/.vimrc.plugin
endif
" }}}

" vim:set foldmethod=marker commentstring="%s :
