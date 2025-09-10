# `function parametres`

Дата: [[2025-07-23]]
Теги: #cpp
Связи: [[c++]] 

---

**Описание**:
Кроме простых типов в качестве параметров.аргументов можно использоавть сами функции.
Например для параметра фукнции:
**Пример кода**:

```cpp
void Foo(void (*func)()) {
    func();
}
```

Или так:

```cpp
void Foo(void func()()) {
    func();
}
```

Почему так? Потому, что в функциях параметр `func()` разворачивается неявно в `void (func*)`, но в *шаблонах* такое не происхоидт, поэтому необходимо писать только так:
`std::vector<std::function<void()>> lalala`, а не так:
`std::vector<std::function<void(*)>> lalala`

Конструкция `std::function` позволяет пихать не только сами фукнции, но я лямбды 

Можно даже создавать целые массивы:
```cpp
void (*init[3])(int, int) { sum, devide, multiply};

std::function<void(int, int)> init2[3] { sum, devide , multiply};
```