# Smart_Pointers_Deleter
Дата: [[2025-07-24]]
Теги: #cpp
Связи: [[c++]] 

---

**Описание**:
Пользовательский удалитель вместо стандартного `delete`
**Пример кода** для `unique_ptr`:

```cpp
auto deleter = [](A* a) { std::cout << "func call before deletetion" << s; delete a;};
std::unique_ptr<A, decltype(deleter)> UclassA{new A, deleter};
```

**Пример кода** для `shared_ptr`:

```cpp
auto deleter = [](A* a) { std::cout << "func call before deletetion" << s; delete a;};
std::shared_ptr<A> SclassA{new A, deleter};
```

Почему так? Да, потому что тип `deleter` не является частью типа указателя.
Это влияет и на размер умного указателя, в случае с `shared_ptr` размер *не поменяется*, в случае с *unique_ptr* размер *может поменяться* если захватить некоторые внешние переменные например вот так:
**Пример кода** :

```cpp
int lalala = 2;  
auto deleter = [&, &lalala](const A* a) { std::cout << "func call before deletetion" << std::endl; delete a; };  
// --unique_ptr--  
std::unique_ptr<A, decltype(deleter)> UclassA{new A, deleter};  
std::unique_ptr<A> UclassA1 = std::make_unique<A>();  
std::cout << "UClassA1 size - " << sizeof(UclassA1) << " UclassA size - " << sizeof(UclassA) << std::endl;
```
*Результат* размер `UClass1` = 16 байт,  размер `UClass` = 8 байт
Размер `unique_ptr` без захвата конкретных переменных, может быть оптимизирован компилятором через **Empty Base Optimization** (Оптимизация пустого базового класса).

---

_Почему-же не растет размер `shared_ptr`?_
Все дело в управляющем блоке(_control block_), который и хранит *счетчики ссылок* и *прочие данные*, в которые входит и кастомный `deleter`.

![[Pasted image 20250724114016.png]]
Соотвественно размер в 16 байт занимает указатель на исходный объект + указатель на _control block_
- Функция `std::make_shared` всегда создает управляющий блок. Она производит новый объект, на который будет указывать интеллектуальный указатель, так что в момент вызова `std::make_shared` _управляющий блок_ для это го объекта, определенно, не существует.
- Указатели с исключительным владением(`unique_ptr`, `auto_ptr`) не используют _управляющие блоки_, так что никакого _управляющего блока_ для указываемого объекта не существует.[[README]]