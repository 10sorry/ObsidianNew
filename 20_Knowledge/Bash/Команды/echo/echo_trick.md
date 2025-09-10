# Небольшие трюки с `echo`

## Brace expansion

пример:

```bash
echo m{aps,ama,ark}s
```

выведет нам:

`maps,mamas,marks`

пример:

```bash
echo {1..10}
```

выведет нам:

`1 2 3 4 5 6 7 8 9 10`

более продвинутый пример:

```bash
ls *.{cpp,h}
```

выведет нам все cpp, h файлы
