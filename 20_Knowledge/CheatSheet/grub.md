[[linux]] #linux
# Если не рабоатет grub - попробовать следующее

## 1. Проверка, правильно ли примонтированы все нужные файловые системы

```bash
mount /dev/sda2 /mnt
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /run /mnt/run
```

Если у тебя **EFI** раздел, то его тоже:

```bash
mount /dev/sda1 /mnt/boot/efi
```

**Проверь что он действительно EFI:**

```bash
lsblk -f
```

или

```bash
blkid
```

---

## 2. Входим в chroot

```bash
arch-chroot /mnt
```

---

## 3. Проверка наличия grub-install и конфигурации

Проверь установлен ли GRUB:

```bash
pacman -Q grub
```

Если нет — ставим:

```bash
pacman -S grub
```

---

## 4. Переустановить загрузчик

Если **UEFI**:

```bash
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
```

Если **Legacy BIOS**:

```bash
grub-install --target=i386-pc /dev/sda
```

Важно: **/dev/sda**, а не /dev/sda2 — ставится в MBR/GPT.

---

## 5. Обновить конфигурацию GRUB

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```

---

## 6. Проверить fstab на актуальность UUID

Посмотреть UUID:

```bash
blkid
```

И сверить с:

```bash
cat /etc/fstab
```

---

## 7. Выход и размонтирование

```bash
exit
umount -R /mnt
reboot
```

---

Если после этого снова не видит диск как загрузочный — возможно, нужно поправить порядок загрузки в BIOS/UEFI или вручную добавить загрузчик через `efibootmgr`:

Посмотреть текущие загрузочные записи:

```bash
efibootmgr -v
```

Добавить:

```bash
efibootmgr --create --disk /dev/sda --part 1 --label "Arch Linux" --loader /EFI/GRUB/grubx64.efi
```

---

Если хочешь — можешь прямо сейчас кинуть сюда вывод `lsblk -f` и `efibootmgr -v`, я гляну твою разметку и подскажу точно как лучше. Хочешь?
