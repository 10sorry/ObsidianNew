# Команды

## Где хранится конфигурация Git

| Тип конфигурации | Путь | Что задаётся |
|------------------|------|--------------|
| **Системный** (для всех пользователей и репозиториев) | `/etc/gitconfig` (или `C:\ProgramData\Git\config` на Windows) | глобальные параметры, применяемые ко всем репозиториям. |
| **Глобальный** (для текущего пользователя) | `~/.gitconfig`  (или `C:\Users\<имя>\.gitconfig` на Windows) | настройки, которые наследуются всеми вашими репозиториями. |
| **Локальный** (только для конкретного репозитория) | `<repo>/.git/config` | параметры, переопределяющие глобальные и системные. |

> **Tip:**  
>  - `~` – это домашний каталог пользователя (`/home/<имя>` на Linux/macOS, `C:\Users\<имя>` на Windows).  
>  - Можно открыть файл в любом редакторе, но чаще используют команды Git.

### Как задать имя и email через терминал

Git хранит два обязательных поля: **user.name** и **user.email**. Их можно установить как глобально (для всех репозиториев), так и локально (только для текущего).

#### 1. Глобальные настройки (подходит, если вы используете один аккаунт)

```bash
git config --global user.name "eip"
git config --global user.email "eip@gitlab.prz.ru"
```

> После выполнения этих команд в файле `~/.gitconfig` появится секция:

```ini
[user]
    name = Ваше Имя
    email = you@example.com
```
### Конифигурация

```
git config --global color.ui true
git config --global push.default current
git config --global core.editor vim
git config --global user.name "John Doe"
git config --global user.email foo@citrix.com
git config --global diff.tool meld
```
### Working with Local Branch
#### Ветки
```bash
# Посмотреть список всех локальных веток
git branch

# Переключиться на существующую локальную ветку
git checkout branchname

# Создать новую ветку из текущей и переключиться на неё
git checkout -b new-branch-name

# Влить ветку branchname в текущую ветку
git merge branchname

# Влить ветку без fast forward. Так работают pull request'ы.
# Это помогает сохранить историю изменений, привязанную к этой ветке.
# Это продвинутая фича, но попробуй с GUI, чтобы увидеть разницу
# между обычным merge и merge --no-ff
git merge --no-ff branchname

# Мягкое удаление ветки — выдаст ошибку, если ветка не слита
git branch -d branchname

# Жёсткое удаление ветки — удаляет без вопросов. Как rm -rf в bash
git branch -D branchname

```

#### Обновление текущей ветки

**Стандартный рабочий процесс**
```bash
# Посмотреть все коммиты
git log

# Красивый вид коммитов. Можно настроить под себя как угодно.
# Просто загугли, вариантов много :)
git log --pretty=format:"%h %s" --graph

# Посмотреть, над чем работал за последнюю неделю
git log --author='Alex' --after={1.week.ago} --pretty=oneline --abbrev-commit

# Показать только изменения, сделанные в этой ветке
# (предполагается, что она была создана от ветки master)
git log --no-merges master..

# Посмотреть статус текущей ветки
# Часто подсказывает, какие команды можно выполнить дальше
git status

# Краткий статус. Удобно для быстрого обзора
git status -s

# Добавить изменённый файл в индекс (stage)
git add filename

# Добавить все изменённые файлы в индекс
git add .

# Добавить только текстовые файлы и т.д.
git add '*.txt'

# Убрать файл из-под контроля git
git rm filename

# Зафиксировать изменения (сделать коммит). Откроется редактор для ввода сообщения.
# (потом его можно увидеть через git log)
# После коммита изменения становятся частью истории.
git commit

# Быстрая команда для коммита с сообщением в одну строчку
git commit -m 'Текст сообщения коммита'

# Изменение истории :) Если хочешь поправить последний коммит,
# пока он не был отправлен в удалённый репозиторий — можно.
# Сделай новые изменения, добавь их через git add и выполни:
git commit --amend
```

**Для уже смешариков**
```bash
# Убрать изменения из индекса (unstage), но оставить их в файловой системе
git reset

# Убрать изменения из индекса и откатить файлы к состоянию последнего коммита
git reset --hard HEAD

# Вернуться на определённый момент в истории в текущей ветке
git reset tag
git reset <commit-hash>

# Сохранить текущие изменения без коммита в репозиторий
git stash

# А потом вернуть эти изменения обратно
git stash pop

# Откатить файл к предыдущей версии, если изменения ещё не были добавлены в индекс.
# Если изменения уже staged — используй git reset filename или git reset --hard filename
git checkout filename
```

**Сравниваем изменения**
``` bash
# See current changes, that have not been staged yet. 
# Good thing to check before running git add
git diff

# See current changes, that have not been commited yet (including staged changes)
git diff HEAD

# Compare current branch to some other branch
git diff branch-name

# Same as diff, but opens changes via difftool that you have configured
# -d tells it to open it in a directory mode, instead of having to open
# each file one at a time.
git difftool -d

# See only changes made in the current branch (compared to master branch)
# Helpful when working on a stand alone branch for a while
git difftool -d master..

# See only the file names that has changed in current branch
git diff --no-commit-id --name-only --no-merges origin/master...

# Similar to above, but see statistics on what files have changed and how
git diff --stat #Your diff condition
```

### Работаем с удаленной веткой
```bash
# Посмотреть текущие изменения, которые ещё не добавлены в индекс (staged)
# Полезно проверить перед git add
git diff

# Посмотреть текущие изменения, которые ещё не закоммичены (включая те, что уже в индексе)
git diff HEAD

# Сравнить текущую ветку с другой веткой
git diff branch-name

# То же, что и diff, но открыть изменения через настроенный difftool
# Параметр -d откроет изменения в виде сравнения директорий,
# а не по одному файлу
git difftool -d

# Посмотреть только изменения в текущей ветке (по сравнению с веткой master)
# Удобно, если работаешь в своей ветке какое-то время
git difftool -d master..

# Посмотреть только имена файлов, которые изменились в текущей ветке
git diff --no-commit-id --name-only --no-merges origin/master...

# Похоже на предыдущее, но выводит статистику: какие файлы изменились и сколько строк
git diff --stat #твое условие для diff
```

![[git_cheatsheet.html]]