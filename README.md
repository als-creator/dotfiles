## README — Установка dotfiles

Описание
- Набор конфигурационных файлов (dotfiles) и скрипт автоматической установки.

Быстрая автоматическая установка
- Запустите в терминале:
```
curl -fsSL https://raw.githubusercontent.com/als-creator/dotfiles/main/install-dotfiles.sh | sh
```
- Скрипт выполнит копирование/ссылки конфигураций и дополнительные настройки.

Ручная установка
1. Клонировать репозиторий:
```
git clone git@github.com:als-creator/dotfiles.git ~/dotfiles
```
2. Перейти в папку и просмотреть скрипт:
```
cd ~/dotfiles
less install-dotfiles.sh
```
3. Запустить скрипт вручную (без конвейера curl|sh):
```
sh install-dotfiles.sh
```
или с подстановкой оболочки:
```
bash install-dotfiles.sh
```

Безопасность и проверка
- Рекомендуется сначала просмотреть install-dotfiles.sh перед запуском.
- Для тестового запуска используйте оболочку с ограничениями или запуск в отдельном пользователе/контейнере.
- Если скрипт создаёт символьные ссылки, проверьте, не перезапишутся ли важные файлы.

Опции (пример, добавить в скрипт/README)
- --dry-run — показать действия без изменений
- --force — перезаписать существующие файлы без запроса
- --backup — сохранять бэкап (~/.config_backup_TIMESTAMP) перед изменениями

Примеры
- Автоматически:
```
curl -fsSL https://raw.githubusercontent.com/als-creator/dotfiles/main/install-dotfiles.sh | sh
```
- Ручная клонирование + запуск:
```
git clone git@github.com:als-creator/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install-dotfiles.sh --backup
```

Контакты и вклад
- Issues/PR: https://github.com/als-creator/dotfiles
- Предложения: открывайте issue с описанием окружения и желаемых изменений.

Лицензия
- Укажите вашу лицензию (например, MIT) и добавьте файл LICENSE в репозитории.
