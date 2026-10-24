# dotfiles

macOS および Ubuntu (Linux) 環境に対応した dotfiles リポジトリです。
Bash、Neovim、tmux、WezTerm などの設定およびパッケージ導入スクリプトを管理しています。

---

## 📦 主な機能・特徴

- **OS 共通のパッケージ管理**:
  - `packages/packages.list` にて Homebrew（macOS）と APT（Ubuntu）のパッケージ名を一箇所で一元管理。
  - Ubuntu 26.04 LTS では `gh`・git-delta・Lazygit・Neovim を含め、標準の APT リポジトリから導入。
- **Shell (Bash)**:
  - OS 固有の設定（`macos.bash` / `linux.bash`）を自動判別して読み込み。
  - 共通設定は `.bashrc`、マシン固有の PATH・環境変数は管理対象外の `~/.bash_profile` に配置。
  - `bash-completion`（補完機能の強化）、`fzf` キーバインド、OSC 7（カレントディレクトリ通知）のサポート。
- **エディタ・開発環境**:
  - **Neovim**: [LazyVim](https://www.lazyvim.org/) をベースとした高速な Lua 設定。
  - **tmux**: 快適なターミナルマルチプレクサ設定。
  - **Lazygit**: Git TUI 本体の導入と設定。差分表示に `delta` を使用。
  - **GitHub CLI (`gh`)**: 本体の導入。認証情報は各環境で管理。
  - **WezTerm**: ターミナルエミュレータの設定。
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
│   └── ubuntu.sh       # Ubuntu 26.04 LTS (APT) 向けセットアップ
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

| ツール | macOS | Ubuntu 26.04 |
| --- | --- | --- |
| `gh` | Homebrew | 標準の APT リポジトリ（`universe`） |
| Lazygit・Neovim・git-delta | Homebrew | 標準の APT リポジトリ（`universe`） |

Ubuntu ではディストリビューションが提供するバージョンを使用し、更新も APT で管理します。

#### macOS の場合
Homebrew のインストール（未導入時）および必要なパッケージ・補完設定を一括で適用します。

```bash
bash packages/macos.sh
```

#### Ubuntu 26.04 LTS の場合
`apt-get` でパッケージ情報を更新し、共通一覧のパッケージを導入します。
`universe` が有効である必要があります。Docker の Ubuntu 26.04 イメージでは有効です。
以前の Ubuntu や Debian ではパッケージの提供状況・バージョンが異なるため、この手順の対象外です。

```bash
sudo bash packages/ubuntu.sh
```

以前のスクリプトで導入済みの環境では、`/usr/local/bin` の Lazygit・Neovim が APT 版より優先される場合があります。
`command -v lazygit nvim delta` で使用する実行ファイルを確認し、既存の手動導入分を整理してから移行してください。Docker イメージを作り直す場合はこの作業は不要です。

### 3. 設定ファイルのシンボリックリンク作成

各ツールの設定ファイルをホームディレクトリ（`~` および `~/.config/`）にリンクします。

```bash
bash install.sh
```

リンク先の既存ファイル・ディレクトリは dotfiles の内容に置き換えます。自動バックアップは行いません。

### 4. マシン固有の Bash 設定

`~/.bashrc` はリポジトリで管理し、マシン固有の PATH・環境変数は `~/.bash_profile` に記述します。
`install.sh` は `~/.bash_profile` を変更しません。macOS のパッケージ導入スクリプトは、`.bashrc` の読み込み行を必要に応じて追加します。
Ubuntu では各環境のログイン設定を確認し、必要に応じて次の内容を追加してください。

```bash
# 共通の対話シェル設定
[ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"

# マシン固有の例（実際のインストール先に合わせて変更）
export PATH="$HOME/tools/bin:$PATH"
```

`.bash_profile` はログインシェルで読み込まれ、export した環境変数は子プロセスに引き継がれます。
既存の `~/.profile` に設定がある場合、`.bash_profile` を作成すると Bash は `.profile` を自動で読まなくなるため、必要な設定を引き継いでください。
GUI やエージェントなど別の経路から起動するプロセスでは、起動元でも必要な環境変数を用意します。

### 5. GitHub CLI の認証

認証情報は dotfiles に含めず、各マシン・コンテナで設定します。

```bash
gh auth login
```

自動実行するコンテナでは、起動時に `GH_TOKEN` を渡す方法も利用できます。
ログイン後の認証情報を Docker イメージやリポジトリに含めないようにします。

---

## 🛠️ パッケージの追加・変更方法

APT / Homebrew で導入するパッケージは、`packages/packages.list` に追記すると両環境のインストール対象に反映されます。

```text
# <論理名>           <Homebrew名 (macOS)>   <APT名 (Ubuntu)>
ripgrep             ripgrep                ripgrep
bash-completion     bash-completion@2      bash-completion
fd                  fd                     fd-find
```

- パッケージ名が異なる場合はそれぞれの列に正しいパッケージ名を指定します。
- 一方の OS のみに導入したい場合は、対象外の列に `-` を指定します。
- `-` はそのパッケージ管理ツールで導入しないことを意味します。

---

## 🐳 Docker による動作確認

Ubuntu 26.04 LTS 環境での動作確認用 Dockerfile が用意されています。

```bash
# イメージのビルド
docker build -t dotfiles-test -f docker/dockerfile .

# コンテナの起動・シェルへログイン
docker run --rm -it dotfiles-test

# 一般ユーザーで各ツールが起動することを確認
docker run --rm dotfiles-test bash -lc 'gh --version && lazygit --version && nvim --version && delta --version'
```
