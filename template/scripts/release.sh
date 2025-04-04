#!/bin/bash
set -e

# 检查是否提供了版本号
if [ -z "$1" ]; then
    echo "用法: $0 <版本号>"
    echo "示例: $0 0.2.0"
    exit 1
fi

VERSION=$1

# 确认版本号格式是否正确
if ! [[ $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "错误: 版本号格式不正确，必须符合语义化版本规范 (例如: 1.0.0)"
    exit 1
fi

# 确认是否要继续
echo "准备发布版本 v$VERSION"
read -p "确认继续? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "已取消发布流程"
    exit 0
fi

# 确保当前分支是主分支
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "错误: 必须在 main 分支上执行发布"
    exit 1
fi

# 确保工作目录干净
if [ -n "$(git status --porcelain)" ]; then
    echo "错误: 工作目录不干净，请先提交或暂存所有更改"
    exit 1
fi

# 拉取最新的更改
git pull origin main

# 检查 cargo-edit 是否安装
if ! command -v cargo-set-version &> /dev/null; then
    echo "安装 cargo-edit..."
    cargo install cargo-edit
fi

# 更新 Cargo.toml 中的版本号
echo "更新 Cargo.toml 中的版本号为 $VERSION..."
cargo set-version "$VERSION"

# 检查 git-cliff 是否安装
if ! command -v git-cliff &> /dev/null; then
    echo "安装 git-cliff..."
    cargo install git-cliff
fi

# 生成 CHANGELOG.md
echo "生成变更日志..."
git-cliff -o CHANGELOG.md --tag "$VERSION"

# 提交更改
echo "提交版本更新..."
git add Cargo.toml Cargo.lock CHANGELOG.md
git commit -m "chore: bump version to v$VERSION"

# 创建标签
echo "创建标签 v$VERSION..."
git tag -a "v$VERSION" -m "Release v$VERSION"

# 推送到远程仓库
echo "推送更改和标签到远程仓库..."
git push origin main
git push origin "v$VERSION"

echo "✅ 版本 v$VERSION 发布完成!"
echo "现在 GitHub Actions 将自动创建 Release"
