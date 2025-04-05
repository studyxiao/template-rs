# Rust Template

> [!WARNING]
> 由于 `cargo-generate` 未提供在最终文件夹下操作的功能，所以，如 `pre-commit install` 这样的命令需要在创建完项目后手动执行。
>
> issue: https://github.com/cargo-generate/cargo-generate/issues/1347

## 环境设置

你可以使用提供的安装脚本一键设置开发环境：

```bash
curl -sSfL https://raw.githubusercontent.com/studyxiao/template-rs/refs/heads/main/install.sh | sh
```

或在 使用 `cargo generate` 时选择 `执行初始化脚本`。

```bash
# -a 表示允许执行 hooks 脚本中的命令
cargo generate -a studyxiao/template-rs
# 🤷   Project Name: test
# 🔧   Destination:  ...
# 🔧   project-name: test ...
# 🔧   Generating template ...
# ? 🤷   是否执行初始化脚本（安装开发工具） ›
#  false
# ❯ true
```

该脚本会自动安装以下所有工具。

### 安装 Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### 安装 cargo generate

cargo generate 是一个用于生成项目模板的工具。它可以使用已有的 github repo 作为模版生成新的项目。

```bash
cargo install cargo-generate
```

如：

```bash
cargo generate studyxiao/template-rs
```

### 安装 pre-commit

pre-commit 是一个代码检查工具，可以在提交代码前进行代码检查。

推荐使用 uv 安装：

```bash
# 如果没有安装 uv，先安装 uv
curl -LsSf https://astral.sh/uv/install.sh | sh

# 使用 uv 安装 pre-commit
uv tool install pre-commit
```

安装成功后，在项目下手动运行 `pre-commit install`。

### 安装 typos

typos 是一个拼写检查工具。

```bash
cargo install typos-cli
```

### 安装 git cliff

git cliff 是一个生成 changelog 的工具。

```bash
cargo install git-cliff
```

### 安装 cargo nextest

cargo nextest 是一个 Rust 增强测试工具。

```bash
cargo install cargo-nextest --locked
```
