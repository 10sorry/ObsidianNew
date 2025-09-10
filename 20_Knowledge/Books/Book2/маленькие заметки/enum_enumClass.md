[[c++]] #cpp
### Преимущества и недостатки `enum class` перед `enum`

1) Область видимости
```cpp
enum Color { red, blue, green};
auto red = 0; // ошибка так как весь enum и есть его данные, то red, blue, green расправстраняются и на всю видимость enum
```
а теперь применим `enum class`
```cpp
enum class Color { red, blue, green};
auto red = 0; // все ок!
```

2) также `enum class` строже типизирован, то есть не получится неявно преобразовать допустим тот же `Color::red` в тип `bool`

3) Кроме того в `enum class` доступно объявление , без инициализации:
```cpp
enum Color; // Ошибка!
enum class Color; // все ок
```

4) также при добавлении нового элемента в `enum class` не придется перекомпилировать всю систему полностью, так например:

```cpp
enum class Status; // при обавлении нового элемента фукнция lalala не перекомпилируется
void lalala(Status s);
```
