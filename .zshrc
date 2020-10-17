#　補完機能ON
autoload -Uz compinit && compinit
# コマンドの履歴機能
# 履歴ファイルの保存先
HISTFILE=$HOME/.zsh_history
# メモリに保存される履歴の件数
HISTSIZE=10000
# HISTFILE で指定したファイルに保存される履歴の件数
SAVEHIST=10000
# オプション設定 
setopt auto_cd 	            # コマンドじゃなければ cd する
setopt auto_param_keys      # カッコの対応などを自動的に補完
setopt auto_param_slash     # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_list	        # 曖昧な補完で、自動的に選択肢をリストアップ
setopt list_types           # 補完候補一覧でファイルの種別をマーク表示
setopt magic_equal_subst    # --prefix=/usr などの = 以降も補完
setopt globdots             # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt complete_in_word     # 語の途中でもカーソル位置で補完
setopt always_last_prompt   # カーソル位置は保持したままファイル名一覧を順次その場で表示

setopt autopushd            # cd 時に自動で push
setopt pushd_ignore_dups    # 同じディレクトリを pushd しない
setopt hist_ignore_all_dups # 重複するコマンドが記憶されるとき、古い方を削除する。
setopt hist_ignore_dups     # 直前と同じコマンドをヒストリに追加しない
setopt hist_save_no_dups    # 重複するコマンドが保存されるとき、古い方を削除する。
setopt hist_reduce_blanks   # 余計な空白は除去して記録
setopt extended_history     # zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt hist_verify          # ヒストリを呼び出してから実行する間に一旦編集
setopt share_history        # ヒストリを共有

setopt nobeep               # ビープを鳴らさない
setopt auto_resume          # サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt print_eight_bit      # 出力時8ビットを通す
setopt interactive_comments # コマンドラインでも # 以降をコメントと見なす
unsetopt promptcr           # 出力の文字列末尾に改行コードが無い場合でも表示

zstyle ':completion:*:default' menu select=1                               # 補完候補を一覧表示し、Tabや矢印で選択できるようにする
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'    # 普通に補完→ 小文字を大文字にして補完→ 大文字を小文字にして補完

# zplugの設定
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "plugins/git", from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"
#zplug "docker/cli", use:"contrib/completion/zsh/_docker"
zplug "mollifier/cd-gitroot"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "junegunn/fzf", use:"shell/*.zsh", as:plugin
zplug "b4b4r07/enhancd", use:init.sh
zplug "greymd/docker-zsh-completion"

zplug "mafredri/zsh-async" # 非同期処理できるようになる
#zplug "sindresorhus/pure" # テーマ
zplug 'dracula/zsh', as:theme # テーマ
zplug "zsh-users/zsh-syntax-highlighting" # 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-history-substring-search" # コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
zplug "zsh-users/zsh-autosuggestions" # 過去に入力したコマンドの履歴が灰色のサジェストで出る
zplug "zsh-users/zsh-completions" # 補完強化
zplug "chrissicool/zsh-256color" # 256色表示にする
zplug "mrowa44/emojify", as:command # コマンドライン上の文字リテラルの絵文字を emoji 化する

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# alias
alias ls="ls -G"
alias la="ls -a"
alias ll="ls -lh"
alias vdf='vim `find ~/dotfiles -type f -d 1 | fzf --select-1 --preview "cat {}"`' 
alias memo='vim ~/Documents/memo/`date +%Y-%m-%d`.md'

# functions
function ide() {
    tmux split-window -v -p 30
    tmux split-window -h -p 66
    tmux split-window -h -p 50
}


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
