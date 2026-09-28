# dotfiles

macOS および Ubuntu (Linux) 環境に対応した dotfiles リポジトリです。  
Bash、Neovim、tmux、WezTerm などの設定およびパッケージ導入スクリプトを管理しています。

---

## 📦 主な機能・特徴

- **OS 共通のパッケージ管理**:
  - `packages/packages.list` にて Homebrew（macOS）と APT（Ubuntu）のパッケージ名を一箇所で一元管理。
  - `git-delta` や `Neovim` など、ディストリビューション公式リポジトリにないツールもアーキテクチャ（arm64 / amd64）を自動判別して導入。
- **Shell (Bash)**:
  - OS 固有の設定（`macos.bash` / `linux.bash`）を自動判別して読み込み。
  - `bash-completion`（補完機能の強化）、`fzf` キーバインド、OSC 7（カレントディレクトリ通知）のサポート。
- **エディタ・開発環境**:
  - **Neovim**: [LazyVim](https://www.lazyvim.org/) をベースとした高速な Lua 設定。
  - **tmux**: 快適なターミナルマルチプレクサ設定。
  - **WezTerm / Lazygit**: ターミナルエミュレータおよび Git TUI の設定。
- **Docker テスト環境**:
  - Ubuntu コンテナ上で dotfiles のセットアップと動作を即座に検証可能。

---

## 📁 ディレクトリ構成

```text
.
├── bash/               # Bash 設定ファイル
│   ├── .bashrc         # 共通のシェル設定
│   ├── macos.bash      # macOS (Homebrew) 固有の設定
│   └── linux.bash      # Linux 固有の設定
├── docker/             # 動作検証用 Docker 環境
│   └── dockerfile
├── lazygit/            # Lazygit 設定 (config.yml)
├── nvim/               # Neovim (LazyVim) 設定
├── packages/           # パッケージ管理スクリプト群
│   ├── packages.list   # パッケージ定義テーブル（一元管理）
│   ├── common_loader.sh# パッケージ読み込み用共通モジュール
│   ├── macos.sh        # macOS (Homebrew) 向けセットアップ
│   └── ubuntu.sh       # Ubuntu (APT / GitHub) 向けセットアップ
├── tmux/               # tmux 設定 (.tmux.conf)
├── wezterm/            # WezTerm 設定 (wezterm.lua)
├── install.sh          # シンボリックリンク配置スクリプト
└── .editorconfig       # エディタ共通設定（インデント等）
```

---

## 🚀 セットアップ手順

### 1. リポジトリのクローン

```bash
git clone https://github.com/rx-93-debugon/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. パッケージのインストール

お使いの OS に合わせてセットアップスクリプトを実行します。

#### macOS の場合
Homebrew のインストール（未導入時）および必要なパッケージ・補完設定を一括で適用します。

```bash
bash packages/macos.sh
```

#### Ubuntu / Debian の場合
APT パッケージの更新・導入および GitHub からの最新バイナリ取得を行います。

```bash
bash packages/ubuntu.sh
```

### 3. 設定ファイルのシンボリックリンク作成

各ツールの設定ファイルをホームディレクトリ（`~` および `~/.config/`）にリンクします。

```bash
bash install.sh
```

---

## 🛠️ パッケージの追加・変更方法

新しいパッケージを追加したい場合は、`packages/packages.list` に追記するだけで両環境に反映されます。

```text
# <論理名>           <Homebrew名 (macOS)>   <APT名 (Ubuntu)>
ripgrep             ripgrep                ripgrep
bash-completion     bash-completion@2      bash-completion
fd                  fd                     fd-find
```

- パッケージ名が異なる場合はそれぞれの列に正しいパッケージ名を指定します。
- 一方の OS のみに導入したい場合は、対象外の列に `-` を指定します。

---

## 🐳 Docker による動作確認

Ubuntu 環境での動作確認用 Dockerfile が用意されています。

```bash
# イメージのビルド
docker build -t dotfiles-test -f docker/dockerfile .

# コンテナの起動・シェルへログイン
docker run --rm -it dotfiles-test
```
