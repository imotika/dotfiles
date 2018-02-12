if !has('gui_running')
  finish
endif

"カラースキーマの設定
colorscheme molokai
set background=dark

"ビープ音を無効にする
set visualbell t_vb=

"どのモードでもマウスを利用できるようにする
set mouse=a

"半透明にする
autocmd GUIEnter * set transparency=200

