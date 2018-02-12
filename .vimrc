"NeoBundleの設定"{{{
    if has('vim_starting')
      set nocompatible
      set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

    call neobundle#begin(expand('~/.vim/bundle/'))

    NeoBundleFetch 'Shougo/neobundle.vim'

    "Unite
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'Shougo/neomru.vim'
    NeoBundle 'Shougo/unite-outline'
    NeoBundle 'ujihisa/unite-colorscheme'
    "ファイラー
    NeoBundle 'Shougo/vimfiler.vim'
    "カラースキーマ
    NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'croaker/mustang-vim'
    NeoBundle 'nanotech/jellybeans.vim'
    NeoBundle 'tomasr/molokai'
    NeoBundle 'w0ng/vim-hybrid'
    NeoBundle 'sickill/vim-monokai'
    "テキストオブジェクトをもっと便利に
    NeoBundle 'tpope/vim-surround'
    NeoBundle 'kana/vim-textobj-user'
    NeoBundle 'akiyan/vim-textobj-php'
    NeoBundle 'osyo-manga/vim-textobj-multiblock'
    NeoBundle 'kana/vim-textobj-function'
    NeoBundle 'thinca/vim-textobj-comment'
    "Emmetプラグイン
    NeoBundle 'mattn/emmet-vim'
    "JSON表示用プラグイン
    NeoBundle 'elzr/vim-json'
    "コメントアウト
    NeoBundle 'tyru/caw.vim'
    "ステータスラインのカスタマイズ
    NeoBundle 'itchyny/lightline.vim'
    "カーソル移動拡張
    NeoBundle 'rhysd/clever-f.vim'
    NeoBundle 'rhysd/accelerated-jk'
    NeoBundle 'Lokaltog/vim-easymotion'
    "選択領域の移動
    NeoBundle 't9md/vim-textmanip'
    "コマンドを素早く実行
    NeoBundle 'thinca/vim-quickrun'
    "ブラウザを素早く開く
    NeoBundle 'tyru/open-browser.vim'
    "整列プラグイン
    NeoBundle 'junegunn/vim-easy-align'
    "対応する括弧を自動で挿入
    NeoBundle 'jiangmiao/auto-pairs'
    "Vimを1つのインスタンスで使う
    NeoBundle 'thinca/vim-singleton'
    "テンプレート管理
    NeoBundle 'mattn/sonictemplate-vim'
    "editorconfig
    "NeoBundle 'editorconfig/editorconfig-vim'
    "カレンダー
    NeoBundle 'itchyny/calendar.vim'
    "バッファをサムネイルで選択
    NeoBundle 'itchyny/thumbnail.vim'
    "Git
    NeoBundle 'tpope/vim-fugitive'
    "個人プラグイン
    NeoBundle 'knt45/jq-wrapper.vim'
    NeoBundle 'knt45/my-vimtoggle'
    "markdown
    NeoBundle 'plasticboy/vim-markdown'
    NeoBundle 'kannokanno/previm'

    call neobundle#end()

    filetype plugin indent on

    NeoBundleCheck
"}}}

"vim-singletonの設定"{{{
    "call singleton#enable()
"}}}
"pre-vimの設定"{{{
    au BufRead,BufNewFile *.md set filetype=markdown
    let g:previm_open_cmd = 'open -a Firefox'
"}}}

"各種設定"{{{
    "シンタックスハイライトを有効にする
    syntax on
    "モードラインをONにする
    set modeline
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
"}}}

"autocmdの設定{{{
    autocmd BufEnter * silent! lcd %:p:h
"}}}

"Tab設定{{{
    " Anywhere SID.
    function! s:SID_PREFIX()
      return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
    endfunction

    " Set tabline.
    function! s:my_tabline()  "{{{
      let s = ''
      for i in range(1, tabpagenr('$'))
        let bufnrs = tabpagebuflist(i)
        let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
        let no = i  " display 0-origin tabpagenr.
        let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
        let title = fnamemodify(bufname(bufnr), ':t')
        let title = '[' . title . ']'
        let s .= '%'.i.'T'
        let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
        let s .= no . ':' . title
        let s .= mod
        let s .= '%#TabLineFill# '
      endfor
      let s .= '%#TabLineFill#%T%=%#TabLine#'
      return s
    endfunction "}}}
    let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
"}}}

"キーマッピング"{{{
    "-----------------------------------------------------------------------------------"
    " Mappings                                                                          |
    "-----------------------------------------------------------------------------------"
    " コマンド        | ノーマル | 挿入 | コマンドライン | ビジュアル | 選択 | 演算待ち |
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

    "x キー削除でデフォルトレジスタに入れない
    nnoremap x "_x
    vnoremap x "_x
    "コンマの後に自動的にスペースを挿入
    inoremap , ,<Space>
    "履歴検索
    "nnoremap : q:a
    "nnoremap / q/a
    "nnoremap ? q?a
    "行末への移動
    nnoremap <C-\> $
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
    "全選択する
    nnoremap <Leader>a ggVG

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

    "新しいタブを開く
    "nnoremap <Leader>t :tabnew<CR>
    "開いているタブを閉じる
    "nnoremap <Leader>w :tabclose<CR>
    "インデント後に再選択
    vnoremap < <gv
    vnoremap > >gv
    "vimrcとgvimrcの編集、保存、読み込み
    nnoremap <Leader>v :e $MYVIMRC<CR>
    nnoremap <Leader>g :e $MYGVIMRC<CR>
    nnoremap <Leader>s :up $MYVIMRC<Bar>:up $MYGVIMRC<BAR>:source $MYVIMRC<BAR>:source $MYGVIMRC<CR>
    "ハイライトを消す
    nnoremap <Esc> :nohlsearch<CR>
    "ENTERキーでカーソル行の真下に空行を追加
    nnoremap <CR> o<ESC>
    " insertモードから抜ける
    inoremap <silent> jj <ESC>
    inoremap <silent> <C-j> j
    inoremap <silent> kk <ESC>
    inoremap <silent> <C-k> k

    " 行頭・行末移動方向をキーの相対位置にあわせる
    "nnoremap 0 $ 
    "nnoremap 1 0 

    " 挿入モードでのカーソル移動
    inoremap <C-j> <Down>
    inoremap <C-k> <Up>
    inoremap <C-h> <Left>
    inoremap <C-l> <Right>

    " カーソル前の文字削除
    inoremap <silent> <C-h> <C-g>u<C-h>
    " カーソル後の文字削除
    inoremap <silent> <C-d> <Del>
    " カーソルから行頭まで削除
    inoremap <silent> <C-d>e <Esc>lc^
    " カーソルから行末まで削除
    inoremap <silent> <C-d>0 <Esc>lc$
    " カーソルから行頭までヤンク
    inoremap <silent> <C-y>e <Esc>ly0<Insert>
    " カーソルから行末までヤンク
    inoremap <silent> <C-y>0 <Esc>ly$<Insert>

    " 引用符, 括弧の設定
    inoremap { {}<Left>
    inoremap [ []<Left>
    inoremap ( ()<Left>
    inoremap " ""<Left>
    inoremap ' ''<Left>
    inoremap <> <><Left>
"}}}

"open_browser.vimの設定"{{{
let g:netrw_nogx = 1
nmap gx (openbrowser-smart-search)
vmap gx (openbrowser-smart-search)

if has('win32') || has('win64')
 let g:openbrowser_browser_commands = [
 \   {
 \       "name": "C:\\Program\ Files\ (x86)\\Google\\Chrome\\Application\\chrome.exe",
 \       "args": ["{browser}", "{uri}"]
 \   }
 \ ]
endif
"}}}

"caw.vimの設定"{{{
    "Ctrl+cでコメントアウトのON/OFF
    xmap <C-c> <Plug>(caw:i:toggle)
    nmap <C-c> <Plug>(caw:i:toggle)
"}}}

"accelerated-jkの設定"{{{
    nmap j <Plug>(accelerated_jk_gj)
    nmap k <Plug>(accelerated_jk_gk)
"}}}

"vim-easy-alignの設定"{{{
    vmap <Enter> <Plug>(EasyAlign)
"}}}

"vim-textmanjpの設定"{{{
    "複製の設定
    xmap <C-S-DOWN> <Plug>(textmanip-duplicate-down)
    nmap <C-S-DOWN> <Plug>(textmanip-duplicate-down)
    "移動の設定
    xmap <M-S-DOWN> <Plug>(textmanip-move-down)
    xmap <M-S-UP> <Plug>(textmanip-move-up)
    xmap <M-S-LEFT> <Plug>(textmanip-move-left)
    xmap <M-S-RIGHT> <Plug>(textmanip-move-right)
"}}}

"open-browser.vimの設定"{{{
    nmap <Leader>q <Plug>(openbrowser-smart-search)
    vmap <Leader>q <Plug>(openbrowser-smart-search)
"}}}

"vim-textobj-multiblock.vimの設定"{{{
    omap ab <Plug>(textobj-multiblock-a)
    omap ib <Plug>(textobj-multiblock-i)
    vmap ab <Plug>(textobj-multiblock-a)
    vmap ib <Plug>(textobj-multiblock-i)
"}}}

"vim-easymotionの設定"{{{
    "General Configuration
    let g:EasyMotion_do_mapping = 0
    let g:EasyMotion_enter_jump_first = 1
    let g:EasyMotion_space_jump_first = 1

    "Find Motions
    nmap s <Plug>(easymotion-s2)
    xmap s <Plug>(easymotion-s2)
    omap x <Plug>(easymotion-s2)
    let g:EasyMotion_smartcase = 1

    "Line Motions
    map <Space>j <Plug>(easymotion-j)
    map <Space>k <Plug>(easymotion-k)
    let g:EasyMotion_startofline = 0

    "Search Motions
    "`<Tab>` & `<S-Tab>` to scroll up/down a page with next match
    nmap g/ <Plug>(easymotion-sn)
    xmap g/ <Plug>(easymotion-sn)
    omap g/ <Plug>(easymotion-tn)
"}}}

"unite.vimの設定 {{{
    "インサートモードで開始
    let g:unite_enable_start_insert = 1
    "ヒストリー/ヤンク機能を有効化
    let g:unite_source_history_yank_enable =1
    "file_recのキャッシュの最小値/最大値を設定
    let g:unite_source_rec_min_cache_files = 100
    let g:unite_source_rec_max_cache_files = 5000
    "prefix keyの設定
    nmap <Space> [unite]

    "スペースキーとsキーでVimShellを起動
    nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    "スペースキーとfキーでバッファと最近開いたファイル一覧を表示
    nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
    "スペースキーとdキーで最近開いたディレクトリを表示
    nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
    "スペースキーとhキーでヒストリ/ヤンクを表示
    nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
    "スペースキーとtキーでタブを表示
    nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
    "スペースキーとoキーでoutline
    nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
    "スペースキーとcキーでcolorscheme
    nnoremap <silent> [unite]c :<C-u>Unite<Space>colorscheme -auto-preview<CR>
    "スペースキーとENTERキーでfile_rec:!
    nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
    "unite.vimを開いている間のキーマッピング
    autocmd FileType unite call s:unite_my_settings()
    function! s:unite_my_settings()"{{{
        " ESCでuniteを終了
        nmap <buffer> <ESC> <Plug>(unite_exit)
    endfunction"}}}
"}}}

"vimfiler.vimの設定"{{{
    "vimデフォルトのエクスプローラをvimfilerで置き換える
    let g:vimfiler_as_default_explorer = 1
    "セーフモードを無効にした状態で起動する
    let g:vimfiler_safe_mode_by_default = 0
    "自動でカレントディレクトリを移動する
    let g:vimfiler_enable_auto_cd = 1
    "NERDTree的な表示
    nnoremap <Leader>e :VimFilerExplore -split -winwidth=30 -find -no-quit<CR>
    
    "現在開いているバッファをIDE風に開く
    nnoremap <silent> <Leader>z :<C-u>VimFilerBufferDir -split -simple -winwidth=45 -toggle -no-quit<CR>
"}}}

"calendar.vimの設定"{{{
    let g:calendar_views = ['year', 'month', 'week', 'clock']
    nnoremap <Leader>c :Calendar<CR>
"}}}

"thumbnail.vimの設定"{{{
    nnoremap <Leader>b :Thumbnail<CR>
"}}}

"lightline.vimの設定"{{{
    let g:lightline = {
            \ 'active': {
            \   'left': [
            \     ['mode'],
            \     ['fugitive', 'filename']
            \   ]
            \ },
            \ 'component_function': {
            \   'fugitive': 'MyFugitive'
            \ }
            \ }

    function! MyFugitive()
      try
        if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
          let _ = fugitive#head()
          return strlen(_) ? _ : ''
        endif
      catch
      endtry
      return ''
    endfunction
"}}}
"Previm.vimの設定"{{{
    "let g:previm_open_cmd = "open -a GoogleChrome" 
    augroup PrevimSettings
        autocmd!
        autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
    augroup END
"}}}

" vim: foldmethod=marker
" vim: foldlevel=1

