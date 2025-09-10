# Настройка LSP для работы с примонтированной виртуальной машиной

Данная инструкция описывает, как настроить LSP сервер на хост-системе (Arch Linux) для работы с проектами, находящимися на примонтированном диске виртуальной машины (AstraLinux 1.6).

## Проблема

При разработке на хост-системе с примонтированным диском виртуальной машины LSP не может найти заголовочные файлы и библиотеки, что приводит к ошибкам типа "QPSql not found" и подобным.

## Решение

### Шаг 1: Монтирование диска виртуальной машины

```bash
# Примонтировать VMDK диск
vmware-mount ~/path/to/your/vm.vmdk /mnt/vmware-disk/
```

### Шаг 2: Подготовка chroot окружения

Примонтировать системные директории для корректной работы chroot:

```bash
sudo mount --bind /dev /mnt/vmware-disk/dev
sudo mount --bind /proc /mnt/vmware-disk/proc  
sudo mount --bind /sys /mnt/vmware-disk/sys
sudo mount --bind /run /mnt/vmware-disk/run
```

### Шаг 3: Разведка путей в виртуальной машине

Войти в chroot для определения путей к заголовкам и библиотекам:

```bash
sudo chroot /mnt/vmware-disk /bin/bash
```

Внутри chroot выполнить:

```bash
# Проверить компилятор
gcc --version

# Найти стандартные заголовки C++
find /usr -name "iostream" 2>/dev/null

# Проверить Qt заголовки  
ls /usr/include/x86_64-linux-gnu/qt5/

# Системные заголовки
ls /usr/include/x86_64-linux-gnu/

# Выйти из chroot
exit
```

### Шаг 4: Создание .clangd конфигурации

В корне вашего проекта создать файл `.clangd`:

```yaml
CompileFlags:
  Add: 
    - --sysroot=/mnt/vmware-disk
    - -I/mnt/vmware-disk/usr/include/c++/8
    - -I/mnt/vmware-disk/usr/include/c++/8/x86_64-linux-gnu
    - -I/mnt/vmware-disk/usr/include/x86_64-linux-gnu
    - -I/mnt/vmware-disk/usr/include/x86_64-linux-gnu/qt5
    - -I/mnt/vmware-disk/usr/include/x86_64-linux-gnu/qt5/QtCore
    - -I/mnt/vmware-disk/usr/include/x86_64-linux-gnu/qt5/QtSql
    - -I/mnt/vmware-disk/usr/include/x86_64-linux-gnu/qt5/QtWidgets
    - -I/mnt/vmware-disk/usr/include
  Remove:
    - -march=*
    - -mtune=*
CompileDatabase: ./compile_commands.json
```

**Важно:** Пути в конфигурации должны соответствовать путям в вашей системе. В данном примере используются пути для AstraLinux 1.6 с GCC 8.3.0.

### Шаг 5: Настройка neovim

Убедиться, что в конфигурации neovim есть стандартная настройка clangd:

```lua
-- В вашем init.lua
require'lspconfig'.clangd.setup{}  -- без специальных cmd параметров
```

### Шаг 6: Тестирование

1. Открыть проект на хосте:
```bash
cd /mnt/vmware-disk/path/to/your/project
nvim src/main.cpp
```

2. Проверить работу LSP:
```
:LspInfo
```

Должен показать, что clangd подключен и работает без ошибок.

## Альтернативные пути монтирования

Вместо `vmware-mount` можно использовать:

```bash
# Через qemu-img
qemu-img convert -f vmdk -O raw your_vm.vmdk disk.img
sudo losetup -P /dev/loop0 disk.img
sudo mount /dev/loop0p1 /mnt/vmware-disk/
```

## Размонтирование

После окончания работы:

```bash
# Размонтировать системные директории
sudo umount /mnt/vmware-disk/{dev,proc,sys,run}

# Размонтировать основной диск
sudo umount /mnt/vmware-disk
# или для vmware-mount
vmware-mount -d /mnt/vmware-disk
```

## Отладка проблем

### Если LSP не видит заголовки:
1. Проверить правильность путей в `.clangd`
2. Убедиться, что диск виртуальной машины примонтирован
3. Проверить права доступа к файлам проекта

### Если проект не компилируется:
Сборку выполнять внутри chroot:
```bash
sudo chroot /mnt/vmware-disk /bin/bash
cd /home/boss/Lancet-R-SSPD
make clean && make
```

## Преимущества данного подхода

- Использование современного редактора с хост-системы
- Корректная работа LSP с библиотеками виртуальной машины  
- Отсутствие необходимости дублировать настройки окружения
- Высокая производительность (без накладных расходов виртуализации)
