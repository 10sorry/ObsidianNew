[[c++]] #cpp
1. `void Foo(T t);`

|Вызов|Аргумент|Категория|Тип аргумента|Вывод `T`|Тип `t`|
|---|---|---|---|---|---|
|`Foo(a)`|`a`|lvalue|`int`|`int`|`int`|
|`Foo(a1)`|`a1`|lvalue|`const int`|`int`|`int`|
|`Foo(a2)`|`a2`|lvalue|`const int&`|`int`|`int`|
|`Foo(27)`|`27`|rvalue|`int`|`int`|`int`|
2. `void Foo(T& t);`

| Вызов     | Аргумент | Категория | Тип аргумента | Вывод `T`   | Тип `t`      |
| --------- | -------- | --------- | ------------- | ----------- | ------------ |
| `Foo(a)`  | `a`      | lvalue    | `int`         | `int`       | `int&`       |
| `Foo(a1)` | `a1`     | lvalue    | `const int`   | `const int` | `const int&` |
| `Foo(a2)` | `a2`     | lvalue    | `const int&`  | `const int` | `const int&` |
| `Foo(27)` | `27`     | rvalue    | `int`         | —           | — (ошибка)   |
3. `void Foo(const T& t);`

| Вызов     | Аргумент | Категория | Тип аргумента | Вывод `T` | Тип `t`      |
| --------- | -------- | --------- | ------------- | --------- | ------------ |
| `Foo(a)`  | `a`      | lvalue    | `int`         | `int`     | `const int&` |
| `Foo(a1)` | `a1`     | lvalue    | `const int`   | `int`     | `const int&` |
| `Foo(a2)` | `a2`     | lvalue    | `const int&`  | `int`     | `const int&` |
| `Foo(27)` | `27`     | rvalue    | `int`         | —         | — (ошибка)   |
4. `void Foo(T&& t);`

|Вызов|Аргумент|Категория|Тип аргумента|Вывод `T`|Тип `t`|
|---|---|---|---|---|---|
|`Foo(a)`|`a`|lvalue|`int`|`int&`|`int&`|
|`Foo(a1)`|`a1`|lvalue|`const int`|`const int&`|`const int&`|
|`Foo(a2)`|`a2`|lvalue|`const int&`|`const int&`|`const int&`|
|`Foo(27)`|`27`|rvalue|`int`|`int`|`int&&`|