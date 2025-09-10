[[c++]] #cpp
### Псевдонимы или `typedef`?

Для сокращения написания сложных типов, например, `std::unique_ptr<std::unordered_map<std::string, std::string>>`

можно использовать `typedef` конструкции:
```cpp
typedef
    std::unique_ptr<std::unordered_map<std::string,std::string>>
UPtrMapSs;
```

но более изящную конструкцию предлагает стандарт *C++11*:
```cpp
using UPtrMapSs = 
    std::unique_ptr<std::unordered_map<std::string, std::string>>;
```
