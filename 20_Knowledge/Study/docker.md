[[linux]] #linux
# Docker в Arch Linux

## Установка Docker

Чтобы установить Docker в Arch Linux и его производные:

`sudo pacman -Syu docker`

## Запуск и добавление в автозагрузку

Запускаем службу Docker:

`sudo systemctl start docker`

Добавляем службу в автозагрузку:

`sudo systemctl enable docker`

Проверяем статус:

`sudo systemctl status docker`

## Добавление пользователя в группу `docker`

Чтобы запускать Docker без `sudo`, добавьте своего пользователя в группу `docker`:

`sudo usermod -aG docker $USER`

**Важно:** после этого перелогиньтесь или перезапустите сессию.

Проверить группы:

`groups`

## Проверка установки

Проверка, что Docker установлен корректно:

`docker --version`

Тестовый запуск контейнера:

`docker run hello-world`

## Базовые команды Docker

- **Список запущенных контейнеров:**

`docker ps`

- **Список всех контейнеров (включая остановленные):**

`docker ps -a`

- **Запуск контейнера:**

`docker run [опции] имя_образа`

Пример:

`docker run -it alpine /bin/sh`

- **Остановка контейнера:**

`docker stop <container_id>`

- **Удаление контейнера:**

`docker rm <container_id>`

- **Список загруженных образов:**

`docker images`

- **Удаление образа:**

`docker rmi <image_id>`

- **Скачивание образа:**

`docker pull имя_образа`

- **Запуск контейнера с пробросом порта:**

`docker run -d -p 8080:80 имя_образа`

## Работа с Docker Compose

Установка:

`sudo pacman -Syu docker-compose`

Проверка версии:

`docker-compose --version`

Пример файла
`docker-compose.yml`:\

```yaml
version: '3'

services:\
  web:\
    image: nginx:latest\
    ports:\
      - "8080:80"
```

Запуск всех сервисов:

`docker-compose up -d`

Остановка всех сервисов:

`docker-compose down`

Просмотр логов:

`docker-compose logs -f`

## Полезные команды

Просмотр логов контейнера:

`docker logs <container_id>`

Интерактивный доступ к работающему контейнеру:

`docker exec -it <container_id> /bin/sh`

Очистка неиспользуемых ресурсов:

`docker system prune -a`

```bash
xhost +local:docker

docker run -it \
    --name astra-1.7 \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    astra:1.7-se /bin/zsh
```

```bash
так что мне надо -

1) Чтобы образ стратовал от пользователя brav в директории /home/brav, на готовом контейнере я делал это через sudo -u brav /bin/bash

2) починить локаль 

3) Добавить в sources list -

# Основной репозиторий (установочный диск)

deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository smolensk main contrib non-free

# Актуальное оперативное обновление основного репозитория

deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-update/ smolensk main contrib non-free

# Диск со средствами разработки

deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-dev/ smolensk main contrib non-free

# Актуальное оперативное обновление диска со средствами разработки

deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-dev-update/ smolensk main contrib non-free

4) Скачать zsh и установить oh-my-zsh через sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```


готовый dockerfile 

```dockerfile
# Базовый образ — твой уже собранный
FROM astra-image:latest

# 1. Создаем пользователя brav (если нет)
RUN id -u brav || useradd -m -s /bin/bash brav

# 2. Настраиваем локаль (чтобы по-русски работало нормально)
RUN echo "ru_RU.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    echo "LANG=ru_RU.UTF-8" > /etc/locale.conf

ENV LANG=ru_RU.UTF-8 \
    LANGUAGE=ru_RU:ru \
    LC_ALL=ru_RU.UTF-8

# 3. Добавляем Astra Linux репозитории в sources.list
RUN echo "deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository smolensk main contrib non-free" > /etc/apt/sources.list && \
    echo "deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-update/ smolensk main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-dev/ smolensk main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb https://dl.astralinux.ru/astra/stable/1.6_x86-64/repository-dev-update/ smolensk main contrib non-free" >> /etc/apt/sources.list

# 4. Обновляем индексы пакетов и устанавливаем zsh и wget (чтобы скачать oh-my-zsh)
RUN apt-get update && apt-get install -y --no-install-recommends zsh wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 5. Устанавливаем oh-my-zsh под пользователем brav
USER brav
WORKDIR /home/brav

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" "" --unattended

# 6. По умолчанию запускаем контейнер от пользователя brav и в его домашней директории
USER brav
WORKDIR /home/brav
CMD ["/bin/zsh"]
```

сбилдить образ на основе dockerfile 
`docker build -t astra-image:zsh-ohmyzsh .`