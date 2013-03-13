" -------------------- 
" .gvimrc
" -------------------- 

" set the colorscheme {{{
let g:hybrid_use_Xresources = 1
colorscheme hybrid
"   colorscheme desert
"   colorscheme molokai
"}}}

" タブ文字、行末など不可視文字を表示する {{{
set list
"listで表示される文字のフォーマットを指定する
"set listchars=tab:▸\ ,trail:¬,eol:▯,extends:»,precedes:«,nbsp:▯
set listchars=tab:▸\ ,trail:¬,extends:»,precedes:«,nbsp:▿

" tabの表示色を設定(コンソールvim使用時はvimrcを編集すること) 
highlight SpecialKey guifg=grey30
" eolの表示色を設定(コンソールvim使用時はvimrcを編集すること) 
highlight clear NonText
highlight NonText guifg=grey30
"}}}

" コマンドラインの高さ(GUI使用時) {{{
set cmdheight=1
let s:ext = fnamemodify(bufname(""), ":e")
"}}}

" 透過 {{{
set transparency=1
augroup hack234
   autocmd!
   if has('mac')
      autocmd FocusGained * set transparency=0
      autocmd FocusLost * set transparency=10
   endif
augroup END
"}}}

" vim:set foldmethod=marker commentstring="%s :
