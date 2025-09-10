[[c++]] #cpp
# 📖 Основные методы `std::string` в C++

`std::string` — это последовательный контейнер символов с кучей удобных методов.  
Вот самые важные и используемые на практике:

---

## 📦 Основные методы

| Метод                          | Описание                                              |
|:--------------------------------|:-------------------------------------------------------|
| `size()` / `length()`          | Возвращает количество символов                        |
| `empty()`                      | Проверка на пустую строку                              |
| `clear()`                      | Очищает строку                                         |
| `c_str()`                      | Возвращает `const char*` для совместимости с C-API     |
| `operator[]` / `at()`          | Доступ к символу по индексу                            |
| `push_back(char)`              | Добавить символ в конец                                |
| `pop_back()`                   | Удалить последний символ                               |
| `append(str)`                  | Добавить строку в конец                                 |
| `insert(pos, str)`             | Вставить строку в позицию                               |
| `erase(pos, count)`            | Удалить часть строки                                    |
| `replace(pos, count, str)`     | Заменить подстроку                                      |
| `substr(pos, count)`           | Вернуть подстроку                                       |
| `find(str)`                    | Найти позицию первой подстроки                          |
| `rfind(str)`                   | Найти позицию последней подстроки                       |
| `find_first_of(str)`           | Найти позицию первого из символов                       |
| `find_last_of(str)`            | Найти позицию последнего из символов                    |
| `compare(str)`                 | Сравнить строки (0 если равны)                          |
| `starts_with(str)` (C++20)     | Проверяет, начинается ли строка с подстроки             |
| `ends_with(str)` (C++20)       | Проверяет, заканчивается ли строка на подстроку         |

---

## 📌 Примеры использования

```cpp
#include <iostream>
#include <string>

int main() {
    std::string s = "Hello";

    s.push_back('!');
    std::cout << s << std::endl; // Hello!

    s.append(" World");
    std::cout << s << std::endl; // Hello! World

    s.insert(5, ",");
    std::cout << s << std::endl; // Hello,! World

    s.replace(0, 5, "Hi");
    std::cout << s << std::endl; // Hi,! World

    s.erase(3, 2);
    std::cout << s << std::endl; // Hi World

    std::cout << "Size: " << s.size() << std::endl; // 8

    std::cout << "Substring: " << s.substr(3, 5) << std::endl; // World

    size_t pos = s.find("World");
    if (pos != std::string::npos)
        std::cout << "'World' found at: " << pos << std::endl;

    s.clear();
    std::cout << "Empty? " << std::boolalpha << s.empty() << std::endl; // true
}
