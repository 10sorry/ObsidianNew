  Отлично, всё применилось. После перезагрузки увидите тему с графикой и сглаженным шрифтом.
  Хотите ещё красивее? Варианты:
  • Установить другую тему (например, Tela/Vimix/WhiteSur) и включить её.
  • Поставить свою картинку фоном.

  Команды:
  • Сменить фон (без сторонних тем):


     1 │ sudo install -m644 /путь/к/картинке.png /boot/grub/background.png
     2 │ sudo sed -i 's|^#\?GRUB_BACKGROUND=.*|GRUB_BACKGROUND="/boot/grub/background.png"|' /etc/default/grub
     3 │ sudo grub-mkconfig -o /boot/grub/grub.cfg

  • Включить стороннюю тему (если используете AUR, пример с paru):


     1 │ paru -S grub-theme-vimix   # или grub-theme-tela, whitesur-grub-theme
     2 │ # путь темы может отличаться; чаще всего внутри /usr/share/grub/themes/<имя>/theme.txt
     3 │ sudo sed -i 's|^#\?GRUB_THEME=.*|GRUB_THEME="/usr/share/grub/themes/vimix/theme.txt"|' /etc/default/grub
     4 │ sudo grub-mkconfig -o /boot/grub/grub.cfg

  Как откатить:

     1 │ sudo sed -i '/^GRUB_THEME=/d;/^GRUB_FONT=/d;/^GRUB_BACKGROUND=/d' /etc/default/grub
     2 │ echo 'GRUB_GFXMODE="auto"' | sudo tee -a /etc/default/grub
     3 │ sudo grub-mkconfig -o /boot/grub/grub.cfg

  • Включил графическую тему starfield, исправил GRUB_GFXMODE, добавил качественный шрифт и пересобрал конфиг.