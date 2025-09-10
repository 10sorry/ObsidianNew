[[c++]] #cpp
```cmake
#Установка минимальной версии
cmake_minimum_required(VERSION 3.7.2)

#установка компиляторов и путей до них 
set(CMAKE_C_COMPILER "path to the compiler")
set(CMAKE_CXX_COMPILER "path to the compiler")

# автоматическая обработка инстурментов Qt
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# установка имени проекта 
project(MyProject VERSION 1.0)

# установка стандарта c++ 
set(CMAKE_CXX_STANDART 14)

# установка target
set(target_name lalala)

# установка папка с исходным кодом 
set(source_dir ${CMAKE_SOURCE_DIR})

# автоматический поиск файлов

set(GLOB src_files ${source_dir}/*.cpp)
set(GLOB hdr_files ${source_dir}/*.h)

# поиск библиотек Qt
find_package(Qt5 COMPONENTS Widgets Gui REQUIRED)

# добавление испольняемого файла 

add_executable(${target_name} ${src_files} ${hdr_files})

# линковка библиотек Qt
target_link_libraries(${target_name} Qt5::Widgets)
```

- **`set(CMAKE_AUTOMOC ON)`**: Включает автоматическое использование **Meta-Object Compiler (MOC)**. MOC — это инструмент Qt, который обрабатывает классы, использующие сигналы и слоты, и создает код для поддержки этой функциональности. Когда эта опция включена, CMake автоматически вызывает MOC для всех файлов, которые содержат макросы `Q_OBJECT`, `Q_GADGET` и т.д.

- **`set(CMAKE_AUTORCC ON)`**: Включает автоматическую обработку **Resource Compiler (RCC)**. RCC — это инструмент Qt, который компилирует файлы ресурсов (например, изображения, иконки, файлы `.qrc`) в бинарный формат, который можно включить в программу. С этой опцией CMake автоматически вызывает RCC для файлов ресурсов.

- **`set(CMAKE_AUTOUIC ON)`**: Включает автоматическое использование **User Interface Compiler (UIC)**. UIC — это инструмент Qt, который обрабатывает файлы пользовательского интерфейса `.ui`, созданные с помощью Qt Designer. При включении этой опции CMake автоматически вызывает UIC для обработки файлов `.ui` и преобразования их в код C++.

```cmake
# Указываем минимальную версию CMake, необходимую для проекта
cmake_minimum_required(VERSION 3.14)

# Указываем имя проекта и версию
project(MyQtProject VERSION 1.0)

# Указываем стандарт языка C++ для проекта
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Включаем автоматическую обработку MOC, UIC и RCC (если используем Qt)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

# Ищем и подключаем библиотеки Qt (например, Qt5Widgets)
find_package(Qt5 REQUIRED COMPONENTS Widgets)

# Указываем исходные файлы проекта
set(SOURCES
    src/main.cpp
    src/mainwindow.cpp
)

# Указываем файлы заголовков
set(HEADERS
    hdr/mainwindow.h
)

# Указываем файлы с ресурсами (например, иконки)
set(RESOURCES
    resources.qrc
)

# Создаем исполняемый файл
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS} ${RESOURCES})

# Связываем Qt библиотеки с нашим проектом
target_link_libraries(${PROJECT_NAME} Qt5::Widgets)

# тест синка
```