#!/bin/bash

set -e  # Прервать выполнение при ошибке

REPO_URL="https://github.com/als-creator/dotfiles.git"
TEMP_DIR="$(mktemp -d)"
HOME_DIR="$HOME"

echo "📥 Загрузка dotfiles из $REPO_URL..."
git clone --depth=1 "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1

if [ ! -d "$TEMP_DIR/home" ]; then
  echo "❌ Папка 'home' не найдена в репозитории!"
  exit 1
fi

echo "📂 Копирование файлов в $HOME_DIR..."
# -r — рекурсивно, -f — без подтверждения, -v — показывать действия (опционально)
cp -rf "$TEMP_DIR/home/"* "$HOME_DIR/"

echo "🧹 Очистка временных файлов..."
rm -rf "$TEMP_DIR"

echo "✅ Dotfiles успешно установлены в $HOME_DIR!"
