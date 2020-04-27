set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決
" filetype plugin on and filetype ident on
filetype plugin indent on

" Plugins
call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree' "左ディレクトリツリー
Plug 'tpope/vim-fugitive' "Git連携
Plug 'junegunn/gv.vim' "Gitビューワー
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'ryanoasis/nerd-fonts'
Plug 'vim-jp/vimdoc-ja' "日本語ヘルプ
Plug 'markonm/traces.vim' "検索や置換コマンドのリアルタイムプレビュー
Plug 'terryma/vim-multiple-cursors' "マルチカーソル機能
Plug 'junegunn/fzf' "あいまい検索(コマンド)
Plug 'junegunn/fzf.vim' "あいまい検索
Plug 'w0ng/vim-hybrid' "カラースキーマ(hybrid)
Plug 'godlygeek/tabular' "テキスト縦方向整形
Plug 'plasticboy/vim-markdown' "Markdownシンタックス
Plug 'previm/previm' "Markdownプレビュー
Plug 'tyru/open-browser.vim' "ブラウザ操作
Plug 'mattn/vim-maketable' "csv文字列からMarkdown形式のテーブル生成

call plug#end()

" My Settings
"各種設定"{{{
    "シンタックスチェックをONにする
    syntax enable
    "カラースキーマ
    colorscheme hybrid 
    set background=dark
    "モードラインをONにする
    set modeline
    " 公式サイトではLinuxとmacOSの設定が若干異なるが、Linuxの設定でもmacOSで問題なし
    set guifont=Hack\ Nerd\ Font:h12
    "メニューバーを非表示にする
    set guioptions-=m
    "ツールバーを非表示にする
    set guioptions-=T
    "左右のスクロールバーを非表示にする
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    "水平スクロールバーを非表示にする
    set guioptions-=b
    "OSのクリップボードを使う
    set clipboard=unnamed
    "ルーラーを表示
    set ruler
    "行数を表示
    set number
    "タブの設定
    set expandtab tabstop=4 shiftwidth=4 softtabstop=0
    "インデントの設定
    set autoindent
    set smartindent
    "折り返ししない
    set nowrap
    "スワップファイルを作成しない
    set noswapfile
    "バックアップファイルを作成しない
    set nobackup
    "ステータスラインを常に表示
    set laststatus=2
    "変更中のファイルでも、保存しないで他のファイルを表示
    set hidden
    "他で書き換えられたら自動で読み直す
    set autoread
    "カーソルの上または下に表示する最小限の行数
    set scrolloff=5
    "コマンドラインモードで保存する履歴件数
    set history=100
    "コマンドラインモードでTABキーによるファイル名補完を有効にする
    set wildmenu wildmode=list:longest,full
    "検索時に大文字・小文字を区別しない
    set ignorecase
    "ただし、検索後に大文字小文字が混在しているときは区別する
    set smartcase
    "スペルチェックを有効にする(ただし日本語は除外する)
    set spelllang+=cjk
    set spell
    "不可視文字を可視化する
    set list
    set listchars=tab:>.,trail:_
    "デフォルト文字コードをUTF-8にする"
    set encoding=utf8
    "常にタブラインを表示
    set showtabline=2
    "ヘルプの言語を日本語にする
    set helplang=ja
"}}}

"キーマッピング"{{{
    "-----------------------------------------------------------------------------------"
    " Mappings                                                                          |
    "-----------------------------------------------------------------------------------"
    " コマンド         | ノーマル | 挿入 | コマンドライン | ビジュアル | 選択 | 演算待ち |
    " map  / noremap  |    @     |  -   |       -        |     @      |  @   |    @     |
    " nmap / nnoremap |    @     |  -   |       -        |     -      |  -   |    -     |
    " vmap / vnoremap |    -     |  -   |       -        |     @      |  @   |    -     |
    " omap / onoremap |    -     |  -   |       -        |     -      |  -   |    @     |
    " xmap / xnoremap |    -     |  -   |       -        |     @      |  -   |    -     |
    " smap / snoremap |    -     |  -   |       -        |     -      |  @   |    -     |
    " map! / noremap! |    -     |  @   |       @        |     -      |  -   |    -     |
    " imap / inoremap |    -     |  @   |       -        |     -      |  -   |    -     |
    " cmap / cnoremap |    -     |  -   |       @        |     -      |  -   |    -     |
    "-----------------------------------------------------------------------------------"

    "<Leader>キーをデフォルトの\から<Space>に変更する
    let mapleader = "\<Space>"
    "全選択する
    nnoremap <Leader>a ggVG
    "vimrcと編集、保存、読み込み
    nnoremap <Leader>v :e $MYVIMRC<CR>
    nnoremap <Leader>r :source $MYVIMRC<CR>
    nnoremap <Leader>p "+p
    nnoremap <Leader>P "+P
    vnoremap <Leader>y "+y
    vnoremap <Leader>p "+p
    vnoremap <Leader>P "+P

    " 常にvery magicオプションで検索
    nnoremap /  /\v
    "x キー削除でデフォルトレジスタに入れない
    nnoremap x "_x
    vnoremap x "_x
    "コンマの後に自動的にスペースを挿入
    inoremap , ,<Space>
    "縦方向は論理移動する
    noremap j gj
    noremap k gk
    noremap gj j
    noremap gk k
    "Ctrlキーを押しながらjkキーは+-と同じ動きにする
    noremap <C-j> +
    noremap <C-k> -
    "左右の矢印キーでバッファを移動
    nnoremap <M-LEFT> :bp<CR>
    nnoremap <M-RIGHT> :bn<CR>
    "ハイライトを消す
    nnoremap <Esc> :nohlsearch<CR>
    "ENTERキーでカーソル行の真下に空行を追加
    nnoremap <CR> o<ESC>
    "QuickFixウィンドウ
    nnoremap [q :cprevious<CR>   " 前へ
    nnoremap ]q :cnext<CR>       " 次へ
    nnoremap [Q :<C-u>cfirst<CR> " 最初へ
    nnoremap ]Q :<C-u>clast<CR>  " 最後へ

    " The prefix key.
    nnoremap  [Tag]   <Nop>
    nmap    t [Tag]
    " Tab jump
    " t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
    for n in range(1, 9)
      execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
    endfor
    " tc 新しいタブを一番右に作る
    map <silent> [Tag]c :tablast <bar> tabnew<CR>
    " tx タブを閉じる
    map <silent> [Tag]x :tabclose<CR>
    " tn 次のタブ
    map <silent> [Tag]n :tabnext<CR>
    " tp 前のタブ
    map <silent> [Tag]p :tabprevious<CR>

    "インデント後に再選択
    vnoremap < <gv
    vnoremap > >gv

    " insertモードから抜ける
    inoremap <silent> jj <ESC>
    inoremap <silent> <C-j> j
    " 挿入モードでのカーソル移動をBash風に
    " inoremap <C-a> 0  
    " inoremap <C-e> $  
    " inoremap <C-f> <Left>
    " inoremap <C-b> <Right>
    " inoremap <C-h> <BS>
    " inoremap <C-d> <Del>
    " カーソル前の文字削除
    " inoremap <silent> <C-h> <C-g>u<C-h>
    "inoremap <C-h> <BS>
    " カーソル後の文字削除
    "inoremap <silent> <C-d> <Del>
    "inoremap <C-d> <Del>
    " カーソルから行頭まで削除
    "inoremap <silent> <C-d>e <Esc>lc^
    " カーソルから行末まで削除
    "inoremap <silent> <C-d>0 <Esc>lc$
    " カーソルから行頭までヤンク
    "inoremap <silent> <C-y>e <Esc>ly0<Insert>
    " カーソルから行末までヤンク
    "inoremap <silent> <C-y>0 <Esc>ly$<Insert>

    " vp doesn't replace paste buffer
    function! RestoreRegister()
        let @" = s:restore_reg
        return ''
    endfunction
    function! s:Repl()
        let s:restore_reg = @"
        return "p@=RestoreRegister()\<cr>"
    endfunction
    vmap <silent> <expr> p <sid>Repl()
"}}}

"NERDTreeの設定"{{{
    "NERDTreeを開く
    nnoremap <silent><C-e> :NERDTreeToggle<CR>
"}}}

"vim-airlineの設定"{{{
    let g:airline_theme = 'wombat'
"}}}

"vim-deviconsの設定"{{{
    " フォルダアイコンを表示
    let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
    let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
    " after a re-source, fix syntax matching issues (concealing brackets):
    if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
    endif 
"}}}

"plasticboy/vim-markdownの設定"{{{
    let g:vim_markdown_folding_disabled = 1
    let g:vim_markdown_auto_insert_bullets = 0
    let g:vim_markdown_new_list_item_indent = 0   
"}}}

"previm/previmの設定{{{
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    " リアルタイムプレビュー
    " 保存時
    " 挿入モードを抜けた時
    " ノーマルモードで少しの間(0.5秒くらい)何も押さなかったとき
    " 挿入モードで少しの間(0.5秒くらい)何も押さなかったとき
    let g:previm_enable_realtime = 1
    let g:previm_open_cmd = 'open -a Google\ Chrome'
    " ctrl pでプレビュー
    nnoremap <silent> <C-p> :PrevimOpen<CR>
"}}}

"tyru/open-browser.vimの設定{{{
    let g:netrw_nogx = 1 " disable netrw's gx mapping.
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)
"}}}

if has('gui_running')
    "半透明にする 
    set transparency=25
endif
