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

echo "Копирование файлов в $HOME_DIR..."

# Проверяем наличие файлов и папок в директории home
if find "$TEMP_DIR/home" -mindepth 1 -print -quit | grep . > /dev/null; then
  # Копируем обычные файлы и папки
  cp -rfv "$TEMP_DIR/home/*" "$HOME_DIR/"

  # Обрабатываем скрытые файлы и папки отдельно
  for hidden_file in "$TEMP_DIR/home"/.[^.]@(?:.+); do
    if [[ -e "$hidden_file" ]]; then
      cp -rfv "$hidden_file" "$HOME_DIR/"
    fi
  done
else
  echo "Ошибка: Директория 'home' в репозитории пустая."
  exit 1
fi

echo "Очистка временных файлов..."
rm -rf "$TEMP_DIR"

echo "Dotfiles успешно установлены в $HOME_DIR!"
