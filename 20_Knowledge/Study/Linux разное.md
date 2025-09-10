[[linux]] #linux
Примонтирование диска через smb - 
`sudo mount -t cifs //172.16.1.11/public /mnt/public -o username=boss,password=3371`

Создать архив `tar -cf "Имя архива" "Содержание архива"`
Создать архив со сжатием `tar -caf "Имя архива" "Содержание архива"`

Симлинк приложения

```bash
sudo ln -s nekoray/nekoray /usr/bin/nekoray
```

#### ✅ Решение: создать `.desktop` файл

##### 1. 📁 Путь к ярлыкам:

Для пользователя — клади сюда:
##### 2. 🛠 Пример `.desktop` файла:

Создай файл `superapp.desktop` в `~/.local/share/applications/`:

```bash
[Desktop Entry]
Name=Nekoray
Exec=nekoray
Icon=utilities-terminal  # или путь к кастомной иконке .png/.svg
Type=Application
Categories=Utility;
Terminal=false  # true — если нужно запускать в терминале
```

##### 3. Обновиться 
`update-desktop-database ~/.local/share/applications/`

##### You said:

как скачать видео с ютуба через терминал?

###### ChatGPT said:

Самый простой и надёжный способ — использовать утилиту **yt-dlp** (форк youtube-dl, активнее поддерживается).

### 1. Установка

```bash
sudo apt update
sudo apt install yt-dlp -y

```


```bash
sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    -o /usr/local/bin/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
```


2. Скачивание видео

```bash
yt-dlp "https://www.youtube.com/watch?v=ID"
```


3. Скачать только аудио (mp3, например)

```bash
yt-dlp -f bestaudio --extract-audio --audio-format mp3 "https://www.youtube.com/watch?v=ID"
```

3. Скачать видео в лучшем качестве

```bash
yt-dlp -f "bestvideo+bestaudio/best" "https://youtu.be/6a-onkiHP0g?si=ZGzOvM5W8kfBiUAz"
```

3. Скачивание плейлиста
 
```bash
  yt-dlp -o "%(playlist_index)s - %(title)s.%(ext)s" "https://www.youtube.com/playlist?list=ID"
```

