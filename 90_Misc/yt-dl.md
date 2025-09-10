
```bash
yt-dlp -f "(bv*+ba/b)[protocol^=https]" \
    --merge-output-format mkv \
    -o "%(title)s [%(height)sp] [%(format_id)s].%(ext)s" \
    --hls-prefer-ffmpeg \
    --external-downloader ffmpeg \
    --external-downloader-args "-threads 4" \
    --write-sub --sub-lang en --embed-subs \
    https://www.youtube.com/watch?v=v8w1i3wAKiw

```
Разберём по кусочкам:

1. **`-f "(bv*+ba/b)[protocol^=https]"`**
    
    - `bv*+ba` — берём лучшее видео и лучшее аудио отдельно.
        
    - `/b` — если нет отдельных потоков, берём лучшее целиком.
        
    - `[protocol^=https]` — приоритет HTTPS-потоков (обычно стабильнее, чем Dash).
        
2. **`--merge-output-format mkv`**
    
    - Объединяет видео и аудио в MKV (он универсальный, поддерживает 4K и 8K без проблем).
        
3. **`-o "%(title)s [%(height)sp] [%(format_id)s].%(ext)s"`**
    
    - Красивое имя файла с разрешением и id формата (чтобы легко отличать).
        
4. **`--hls-prefer-ffmpeg` и `--external-downloader ffmpeg`**
    
    - Всегда используем FFmpeg для слияния и скачивания потоков.
        
5. **`--external-downloader-args "-threads 4"`**
    
    - FFmpeg работает в несколько потоков для ускорения.
        
6. **`--write-sub --sub-lang en --embed-subs`**
    
    - Если нужны субтитры, он их сразу вшивает.