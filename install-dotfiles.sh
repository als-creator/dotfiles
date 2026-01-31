#!/bin/bash

set -e  # Прервать выполнение при ошибке

REPO_URL="https://github.com/als-creator/dotfiles.git"
TEMP_DIR="$(mktemp -d)"
HOME_DIR="$HOME"

echo "Загрузка dotfiles из $REPO_URL..."
git clone "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1

if [ ! -d "$TEMP_DIR/home" ]; then
  echo "Ошибка: Папка 'home' не найдена в репозитории!"
  exit 1
fi

echo "Копирование файлов в $HOME_DIR. Проверяем наличие содержимого в директории home перед копированием
if ls "$TEMP_DIR/home/"* &>/dev/null && ls "$TEMP_DIR/home/.
