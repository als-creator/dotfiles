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

echo "Подстановка плейсхолдеров @HOME@/@USER@ в реальные значения..."

# Многие конфиги не умеют раскрывать переменные окружения, поэтому в
# репозитории пути хранятся как @HOME@ (домашний каталог) и @USER@ (логин),
# а при установке подменяются реальными значениями. Заменяем только текстовые
# файлы, в которых действительно встречаются плейсхолдеры.
find "$TEMP_DIR/home" -type f -print0 2>/dev/null | while IFS= read -r -d '' f; do
  if grep -q '@HOME@\|@USER@' "$f" 2>/dev/null; then
    sed -i "s|@HOME@|$HOME_DIR|g; s|@USER@|$USER|g" "$f"
  fi
done

echo "Копирование файлов в $HOME_DIR с сохранением структуры..."

# Копируем содержимое home/ в $HOME (включая .config и скрытые файлы)
# -a = архивный режим (сохраняет права, владельца, timestamps, символические ссылки)
cp -a "$TEMP_DIR/home/." "$HOME_DIR/"

echo "Очистка временных файлов..."
rm -rf "$TEMP_DIR"

echo "✅ Dotfiles успешно установлены в $HOME_DIR!"
ls -la "$HOME_DIR" | head -15  # Покажем что скопировалось
