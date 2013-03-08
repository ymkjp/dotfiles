" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ========== General Config =========="{{{
set title
set number
set modeline
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim
set clipboard+=unnamed

"カーソルを行頭、行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
"日本語の行の連結時には空白を入力しない。
set formatoptions+=mM
"□や○の文字があってもカーソル位置がずれないようにする。
set ambiwidth=double
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

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" ========== Language ==========
" 文字コードの自動認識
if &encoding !=# 'utf-8'
    set encoding=japan
    set fileencoding=japan
endif

" 改行コードの自動認識
set fileformats=unix,dos,mac

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
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" ========== MAPS ==========
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>
" ;でコマンド入力( ;と:を入れ替)
noremap ; :
" CTRL-hjklでウィンドウ移動
nnoremap <C-j> :<C-w>j
nnoremap <C-k> :<C-k>j
nnoremap <C-l> :<C-l>j
nnoremap <C-h> :<C-h>j

" ========== Abbreviations ==========
ab #l ----------
ab #L ==========

"}}}


" ========== PLUGINS ==========
"
"neobundle"{{{
filetype plugin indent off     " required!
 
"initialize"{{{
if has('vim_starting')
  let bundle_dir = '~/.bundle'
  if !isdirectory(bundle_dir.'/neobundle.vim')
    call system( 'git clone https://github.com/Shougo/neobundle.vim.git '.bundle_dir.'/neobundle.vim')
  endif
 
  exe 'set runtimepath+='.bundle_dir.'/neobundle.vim'
  call neobundle#rc(bundle_dir)
endif
 
augroup MyNeobundle
  au!
  au Syntax vim syntax keyword vimCommand NeoBundle NeoBundleLazy NeoBundleSource NeoBundleFetch
augroup END
"}}}

" コマンドを伴うやつの遅延読み込み
function! BundleWithCmd(bundle_names, cmd) "{{{
  call BundleLoadDepends(a:bundle_names)
 
  " コマンドの実行
  if !empty(a:cmd)
    execute a:cmd
  endif
endfunction "}}}
"bundle"{{{
" その他 {{{
NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundleLazy 'taichouchou2/vim-endwise.git', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ } }
" }}}

"basic" {{{
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'scrooloose/nerdtree'

"unite.vim {{{
	" The prefix key.
	nnoremap    [unite]   <Nop>
	nmap    f [unite]

	nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir
	\ -buffer-name=files buffer file_mru bookmark file<CR>
	nnoremap <silent> [unite]b  :<C-u>UniteWithBufferDir
	\ -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
	nnoremap <silent> [unite]r  :<C-u>Unite
	\ -buffer-name=register register<CR>
	nnoremap <silent> [unite]o  :<C-u>Unite outline<CR>
	nnoremap <silent> [unite]f
	\ :<C-u>Unite -buffer-name=resume resume<CR>
	nnoremap <silent> [unite]d
	\ :<C-u>Unite -buffer-name=files -default-action=lcd directory_mru<CR>
	nnoremap <silent> [unite]ma
	\ :<C-u>Unite mapping<CR>
	nnoremap <silent> [unite]me
	\ :<C-u>Unite output:message<CR>
	nnoremap  [unite]f  :<C-u>Unite source<CR>

	nnoremap <silent> [unite]s
	        \ :<C-u>Unite -buffer-name=files -no-split
	        \ jump_point file_point buffer_tab
	        \ file_rec:! file file/new file_mru<CR>

	" Start insert.
	"let g:unite_enable_start_insert = 1
	"let g:unite_enable_short_source_names = 1

	autocmd FileType unite call s:unite_my_settings()
	function! s:unite_my_settings()"{{{
	  " Overwrite settings.

	  nmap <buffer> <ESC>      <Plug>(unite_exit)
	  imap <buffer> jj      <Plug>(unite_insert_leave)
	  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

	imap <buffer><expr> j unite#smart_map('j', '')
	imap <buffer> <TAB>   <Plug>(unite_select_next_line)
	imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
	imap <buffer> '     <Plug>(unite_quick_match_default_action)
	nmap <buffer> '     <Plug>(unite_quick_match_default_action)
	imap <buffer><expr> x
	        \ unite#smart_map('x', "\<Plug>(unite_quick_match_choose_action)")
	nmap <buffer> x     <Plug>(unite_quick_match_choose_action)
	nmap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
	imap <buffer> <C-z>     <Plug>(unite_toggle_transpose_window)
	imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
	nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
	nmap <buffer> <C-j>     <Plug>(unite_toggle_auto_preview)
	nmap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
	imap <buffer> <C-r>     <Plug>(unite_narrowing_input_history)
	nnoremap <silent><buffer><expr> l
	        \ unite#smart_map('l', unite#do_action('default'))

	let unite = unite#get_current_unite()
	if unite.buffer_name =~# '^search'
	  nnoremap <silent><buffer><expr> r     unite#do_action('replace')
	else
	  nnoremap <silent><buffer><expr> r     unite#do_action('rename')
	endif

	nnoremap <silent><buffer><expr> cd     unite#do_action('lcd')
	nnoremap <buffer><expr> S      unite#mappings#set_current_filters(
	\ empty(unite#mappings#get_current_filters()) ? ['sorter_reverse'] : [])
	endfunction"}}}

	let g:unite_source_file_mru_limit = 200
	let g:unite_cursor_line_highlight = 'TabLineSel'
	let g:unite_abbr_highlight = 'TabLine'

	" For optimize.
	let g:unite_source_file_mru_filename_format = ''

	if executable('jvgrep')
	  " For jvgrep.
	  let g:unite_source_grep_command = 'jvgrep'
	  let g:unite_source_grep_default_opts = '--exclude ''\.(git|svn|hg|bzr)'''
	  let g:unite_source_grep_recursive_opt = '-R'
	endif

	" For ack.
	if executable('ack-grep')
	  " let g:unite_source_grep_command = 'ack-grep'
	  " let g:unite_source_grep_default_opts = '--no-heading --no-color -a'
	  " let g:unite_source_grep_recursive_opt = ''
  endif

    " 入力モードで開始する
    " let g:unite_enable_start_insert=1
    " バッファ一覧
    nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
    " ファイル一覧
    nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    " レジスタ一覧
    nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
    " 最近使用したファイル一覧
    nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
    " 常用セット
    nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
    " 全部乗せ
    nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

    " ウィンドウを分割して開く
    au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
    " ウィンドウを縦に分割して開く
    au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
    " ESCキーを2回押すと終了する
    au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
    au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
" }}}

"vimshell" {{{
    let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
    "let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
    let g:vimshell_enable_smart_case = 1

    if has('win32') || has('win64')
      " Display user name on Windows.
      let g:vimshell_prompt = $USERNAME."% "
    else
      " Display user name on Linux.
      let g:vimshell_prompt = $USER."% "

      call vimshell#set_execute_file('bmp,jpg,png,gif', 'gexe eog')
      call vimshell#set_execute_file('mp3,m4a,ogg', 'gexe amarok')
      let g:vimshell_execute_file_list['zip'] = 'zipinfo'
      call vimshell#set_execute_file('tgz,gz', 'gzcat')
        call vimshell#set_execute_file('tbz,bz2', 'bzcat')
    endif

    " Initialize execute file list.
    let g:vimshell_execute_file_list = {}
    call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
    let g:vimshell_execute_file_list['rb'] = 'ruby'
    let g:vimshell_execute_file_list['pl'] = 'perl'
    let g:vimshell_execute_file_list['py'] = 'python'
    call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

    autocmd FileType vimshell
    \ call vimshell#altercmd#define('g', 'git')
    \| call vimshell#altercmd#define('i', 'iexe')
    \| call vimshell#altercmd#define('l', 'll')
    \| call vimshell#altercmd#define('ll', 'ls -l')
    \| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')

    function! g:my_chpwd(args, context)
      call vimshell#execute('ls')
    endfunction

    autocmd FileType int-* call s:interactive_settings()
    function! s:interactive_settings()
    endfunction

    " ,is: シェルを起動
    nnoremap <silent> ,is :VimShell<CR>
    " ,ipy: pythonを非同期で起動
    nnoremap <silent> ,ipy :VimShellInteractive python<CR>
    " ,irb: irbを非同期で起動
    nnoremap <silent> ,irb :VimShellInteractive pry<CR>
    " ,ss: 非同期で開いたインタプリタに現在の行を評価させる
    vmap <silent> ,ss :VimShellSendString<CR>
    " 選択中に,ss: 非同期で開いたインタプリタに選択行を評価させる
    nnoremap <silent> ,ss <S-v>:VimShellSendString<CR>
" }}}

"NERDTree" {{{
    autocmd vimenter * if !argc() | NERDTree | endif
    nnoremap <C-n> :NERDTreeToggle<CR>
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" }}}
" }}}
 
" 補完 {{{
NeoBundleLazy 'Shougo/neocomplcache', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}
NeoBundleLazy 'Shougo/neosnippet', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ }}
NeoBundle 'Shougo/neocomplcache-rsense', {
      \ 'depends': 'Shougo/neocomplcache',
      \ 'autoload': { 'filetypes': 'ruby' }}
NeoBundleLazy 'taichouchou2/rsense-0.3', {
      \ 'build' : {
      \    'mac': 'ruby etc/config.rb > ~/.rsense',
      \    'unix': 'ruby etc/config.rb > ~/.rsense',
      \ } }
" }}}
 
" 便利 {{{
" 範囲指定のコマンドが使えないので、tcommentのLazy化はNeoBundleのアップデートを待ちましょう...
NeoBundle 'tomtom/tcomment_vim'
NeoBundleLazy 'tpope/vim-surround', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>Dsurround'], ['nx', '<Plug>Csurround'],
      \     ['nx', '<Plug>Ysurround'], ['nx', '<Plug>YSurround'],
      \     ['nx', '<Plug>Yssurround'], ['nx', '<Plug>YSsurround'],
      \     ['nx', '<Plug>YSsurround'], ['vx', '<Plug>VgSurround'],
      \     ['vx', '<Plug>VSurround']
      \ ]}}
" }}}
 
" ruby / railsサポート {{{
NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'ujihisa/unite-rake', {
      \ 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'basyura/unite-rails', {
      \ 'depends' : 'Shjkougo/unite.vim' }
NeoBundleLazy 'taichouchou2/unite-rails_best_practices', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'build' : {
      \    'mac': 'gem install rails_best_practices',
      \    'unix': 'gem install rails_best_practices',
      \   }
      \ }
NeoBundleLazy 'taichouchou2/unite-reek', {
      \ 'build' : {
      \    'mac': 'gem install reek',
      \    'unix': 'gem install reek',
      \ },
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] },
      \ 'depends' : 'Shougo/unite.vim' }
 
let s:bundle_rails = 'unite-rails unite-rails_best_practices unite-rake'
 
function! s:bundleLoadDepends(bundle_names) "{{{
  " bundleの読み込み
  execute 'NeoBundleSource '.a:bundle_names
  au! MyAutoCmd
endfunction"}}}
aug MyAutoCmd
  au User Rails call <SID>bundleLoadDepends(s:bundle_rails)
aug END
 
" reference環境
NeoBundleLazy 'vim-ruby/vim-ruby', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundleLazy 'taka84u9/vim-ref-ri', {
      \ 'depends': ['Shougo/unite.vim', 'thinca/vim-ref'],
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundleLazy 'skwp/vim-rspec', {
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundleLazy 'ruby-matchit', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }
" }}}
 
" }}}
 
" Installation check. "{{{
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Install Plugins'
  NeoBundleInstall
endif
"}}}
filetype plugin indent on
"}}}
" plugin settings"{{{
"------------------------------------
" endwise.vim
"------------------------------------
"{{{
let g:endwise_no_mappings=1
"}}}
 
"------------------------------------
" vim-surround
"------------------------------------
" {{{
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround
vmap s   <Plug>VSurround
 
" surround_custom_mappings.vim"{{{
let g:surround_custom_mapping = {}
let g:surround_custom_mapping._ = {
      \ 'p':  "<pre> \r </pre>",
      \ 'w':  "%w(\r)",
      \ }
let g:surround_custom_mapping.help = {
      \ 'p':  "> \r <",
      \ }
let g:surround_custom_mapping.ruby = {
      \ '-':  "<% \r %>",
      \ '=':  "<%= \r %>",
      \ '9':  "(\r)",
      \ '5':  "%(\r)",
      \ '%':  "%(\r)",
      \ 'w':  "%w(\r)",
      \ '#':  "#{\r}",
      \ '3':  "#{\r}",
      \ 'e':  "begin \r end",
      \ 'E':  "<<EOS \r EOS",
      \ 'i':  "if \1if\1 \r end",
      \ 'u':  "unless \1unless\1 \r end",
      \ 'c':  "class \1class\1 \r end",
      \ 'm':  "module \1module\1 \r end",
      \ 'd':  "def \1def\1\2args\r..*\r(&)\2 \r end",
      \ 'p':  "\1method\1 do \2args\r..*\r|&| \2\r end",
      \ 'P':  "\1method\1 {\2args\r..*\r|&|\2 \r }",
      \ }
let g:surround_custom_mapping.javascript = {
      \ 'f':  "function(){ \r }"
      \ }
let g:surround_custom_mapping.lua = {
      \ 'f':  "function(){ \r }"
      \ }
let g:surround_custom_mapping.python = {
      \ 'p':  "print( \r)",
      \ '[':  "[\r]",
      \ }
let g:surround_custom_mapping.vim= {
      \'f':  "function! \r endfunction"
      \ }
"}}}
"}}}
 
"------------------------------------
" neocomplcache
"------------------------------------
" 補完・履歴 neocomplcache "{{{
set infercase
 
"----------------------------------------

	"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplcache.
	let g:neocomplcache_enable_at_startup = 1
	" Use smartcase.
	let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_smart_case = 1
    " Use camel case completion.
    let g:neocomplcache_enable_camel_case_completion = 1
    " Use underscore completion.
    let g:neocomplcache_enable_underbar_completion = 1
	" Set minimum syntax keyword length.
	let g:neocomplcache_min_syntax_length = 3
    " buffer file name pattern that locks neocomplcache. e.g. ku.vim or fuzzyfinder
	let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

	" Enable heavy features.
	" Use camel case completion.
	"let g:neocomplcache_enable_camel_case_completion = 1
	" Use underbar completion.
	"let g:neocomplcache_enable_underbar_completion = 1

	" Define dictionary.
	let g:neocomplcache_dictionary_filetype_lists = {
	    \ 'default' : '',
	    \ 'vimshell' : $HOME.'/.vimshell_hist',
	    \ 'scheme' : $HOME.'/.gosh_completions'
	        \ }

	" Define keyword.
	if !exists('g:neocomplcache_keyword_patterns')
	    let g:neocomplcache_keyword_patterns = {}
	endif
	let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
    inoremap <expr><CR>  neocomplcache#smart_close_popup( . "\<CR>")
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()

	" For cursor moving in insert mode(Not recommended)
	"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
	"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
	"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
	"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
	" Or set this.
	"let g:neocomplcache_enable_cursor_hold_i = 1
	" Or set this.
	"let g:neocomplcache_enable_insert_char_pre = 1

	" AutoComplPop like behavior.
	"let g:neocomplcache_enable_auto_select = 1

	" Shell like behavior(not recommended).
	"set completeopt+=longest
	"let g:neocomplcache_enable_auto_select = 1
	"let g:neocomplcache_disable_auto_complete = 1
	"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

	" Enable omni completion.
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

	" Enable heavy omni completion.
	if !exists('g:neocomplcache_omni_patterns')
	  let g:neocomplcache_omni_patterns = {}
	endif
	let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
	"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
	let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
	let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
	let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

	" For perlomni.vim setting.
	" https://github.com/c9s/perlomni.vim
	let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"------------------------------------
" neosnippet
"------------------------------------
" neosnippet "{{{
 
" snippetを保存するディレクトリを設定してください
" example
" let s:default_snippet = neobundle#get_neobundle_dir() . '/neosnippet/autoload/neosnippet/snippets' " 本体に入っているsnippet
" let s:my_snippet = '~/snippet' " 自分のsnippet
" let g:neosnippet#snippets_directory = s:my_snippet
" let g:neosnippet#snippets_directory = s:default_snippet . ',' . s:my_snippet

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    
    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    
    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif
"}}}
 
"------------------------------------
" vim-rails
"------------------------------------
""{{{
"有効化
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
" let g:rails_some_option = 1
" let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http://localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endfunction
 
aug MyAutoCmd
  au User Rails call SetUpRailsSetting()
aug END
 
aug RailsDictSetting
  au!
aug END
"}}}
 
"------------------------------------
" Unite-rails.vim
"------------------------------------
"{{{
function! UniteRailsSetting()
  nnoremap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
  nnoremap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
  nnoremap <buffer><C-H>            :<C-U>Unite rails/controller<CR>
 
  nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
  nnoremap <buffer><C-H>s           :<C-U>Unite rails/spec<CR>
  nnoremap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
  nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
  nnoremap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
  nnoremap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
  nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  nnoremap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
endfunction
aug MyAutoCmd
  au User Rails call UniteRailsSetting()
aug END
"}}}
 
"----------------------------------------
" vim-ref
"----------------------------------------
"{{{
let g:ref_open                    = 'split'
let g:ref_refe_cmd                = expand('~/.vim/ref/ruby-ref1.9.2/refe-1_9_2')
 
nnoremap rr :<C-U>Unite ref/refe     -default-action=split -input=
nnoremap ri :<C-U>Unite ref/ri       -default-action=split -input=
 
aug MyAutoCmd
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>KK :<C-U>Unite -no-start-insert ref/ri   -input=<C-R><C-W><CR>
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>K  :<C-U>Unite -no-start-insert ref/refe -input=<C-R><C-W><CR>
aug END
"}}}
 
"------------------------------------
" Unite-reek, Unite-rails_best_practices
"------------------------------------
" {{{
nnoremap <silent> [unite]<C-R>      :<C-u>Unite -no-quit reek<CR>
nnoremap <silent> [unite]<C-R><C-R> :<C-u>Unite -no-quit rails_best_practices<CR>
" }}}
"}}}


" JavaScript {{{
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'VimClojure'
NeoBundle 'teramako/jscomplete-vim'

" vim-javascript-syntax {{{
    au FileType javascript call JavaScriptFold()
" }}}

" simple-javascript-indenter {{{
    let g:SimpleJsIndenter_BriefMode = 1
    let g:SimpleJsIndenter_CaseIndentLevel = -1
" }}}

" vim-coffee-script {{{
    nnoremap <silent> <C-C> :CoffeeCompile watch vert<CR>
" }}}

" jscomplete-vim {{{
    autocmd FileType javascript
      \ :setl omnifunc=jscomplete#CompleteJS
    let g:jscomplete_use = ['dom', 'moz', 'es6th']
" }}}

" syntastic {{{
    let g:syntastic_javascript_checker = "jshint"
    " ,scで構文チェック
    nnoremap ,sc :<C-u>SyntasticCheck<CR>
" }}}

" }}}


" ColorScheme {{{
NeoBundle 'w0ng/vim-hybrid'
" }}}

" neocomplcache-rsense {{{
    " Set $RSENSE_HOME path.
    let g:neocomplcache#sources#rsense#home_directory = '/usr/local/Cellar/rsense/'
    let g:rsenseUseOmniFunc = 1
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" }}}


" vim:set foldmethod=marker commentstring="%s :
