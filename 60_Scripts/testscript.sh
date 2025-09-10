#!/bin/bash

# Проверяем переменные окружения
if [[ -z "$XDG_RUNTIME_DIR" ]]; then
  echo "Warning: XDG_RUNTIME_DIR is not set or empty. Skipping mounting XDG_RUNTIME_DIR."
  XDG_RUNTIME_MOUNT=""
  XDG_RUNTIME_ENV=""
else
  if [[ -z "$XDG_SESSION_ID" ]]; then
    echo "Warning: XDG_SESSION_ID is not set or empty. Skipping mounting XDG_RUNTIME_DIR session subdir."
    XDG_RUNTIME_MOUNT=""
    XDG_RUNTIME_ENV=""
  else
    XDG_RUNTIME_MOUNT="-v $XDG_RUNTIME_DIR/$XDG_SESSION_ID:$XDG_RUNTIME_DIR/$XDG_SESSION_ID"
    XDG_RUNTIME_ENV="-e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
  fi
fi

# Строим команду docker run
docker run -it --name ubuntu_9 \
  --device /dev/dri --group-add video \
  -e DISPLAY=$DISPLAY \
  $XDG_RUNTIME_ENV \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  $XDG_RUNTIME_MOUNT \
  ubuntu_with_all:latest

