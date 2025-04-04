#!/usr/bin/env bash

# set -e

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}开始安装 Rust 开发环境...${NC}"

# 安装 Rust
if command -v rustc >/dev/null 2>&1; then
  echo -e "${YELLOW}Rust 已安装，跳过安装步骤${NC}"
else
  echo -e "${GREEN}安装 Rust...${NC}"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# 安装 cargo-generate
if command -v cargo-generate >/dev/null 2>&1; then
  echo -e "${YELLOW}cargo-generate 已安装，跳过安装步骤${NC}"
else
  echo -e "${GREEN}安装 cargo-generate...${NC}"
  cargo install cargo-generate
fi

# 安装 uv
if command -v uv >/dev/null 2>&1; then
  echo -e "${YELLOW}uv 已安装，跳过安装步骤${NC}"
else
  echo -e "${GREEN}安装 uv...${NC}"
  curl -LsSf https://astral.sh/uv/install.sh | sh
  # 添加 uv 到当前 shell 的 PATH
  if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
  fi
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# 安装 pre-commit
if command -v pre-commit >/dev/null 2>&1; then
  echo -e "${YELLOW}pre-commit 已安装，跳过安装步骤${NC}"
else
  echo -e "${GREEN}使用 uv 安装 pre-commit...${NC}"
  uv tool install pre-commit
fi

# 安装 typos
if command -v typos >/dev/null 2>&1; then
  echo -e "${YELLOW}typos 已安装，跳过安装步骤${NC}"
else
  echo -e "${GREEN}安装 typos...${NC}"
  cargo install typos-cli
fi

# 安装 git cliff
if command -v git-cliff >/dev/null 2>&1; then
  echo -e "${YELLOW}git-cliff 已安装，跳过安装步骤${NC}"
else
  echo -e "${GREEN}安装 git cliff...${NC}"
  cargo install git-cliff
fi

# 安装 cargo nextest
if command -v cargo-nextest >/dev/null 2>&1; then
  echo -e "${YELLOW}cargo-nextest 已安装，跳过安装步骤${NC}"
else
  echo -e "${GREEN}安装 cargo nextest...${NC}"
  cargo install cargo-nextest --locked
fi

# 打印 VSCode 插件列表
echo -e "${GREEN}建议安装以下 VSCode 插件:${NC}"
echo "- crates: Rust 包管理"
echo "- Even Better TOML: TOML 文件支持"
echo "- Better Comments: 优化注释显示"
echo "- Error Lens: 错误提示优化"
echo "- GitLens: Git 增强"
echo "- Github Copilot: 代码提示"
echo "- indent-rainbow: 缩进显示优化"
echo "- Prettier - Code formatter: 代码格式化"
echo "- REST client: REST API 调试"
echo "- rust-analyzer: Rust 语言支持"
echo "- Rust Test lens: Rust 测试支持"
echo "- Rust Test Explorer: Rust 测试概览"
echo "- TODO Highlight: TODO 高亮"
echo "- YAML: YAML 文件支持"

echo -e "${GREEN}环境安装完成!${NC}"
