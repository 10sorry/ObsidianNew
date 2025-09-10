# Минимальный `CMakeLists.txt` для запуска приложухи

```CMake
# Минимальная версия
cmake_minimum_required(VERSION 3.16)

# Название
project(
  app1
  VERSION 0.1
  LANGUAGES CXX)

# Указываем станадарт
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.8)

# исполняемый файл
qt_add_executable(app main.cpp)

# Подключаем QML-модуль (чтобы Main.qml и другие подхватывались)
qt_add_qml_module(
  app
  URI
  app1
  VERSION
  1.0
  QML_FILES
  Main.qml)

target_link_libraries(app PRIVATE Qt6::Quick)

# Установка (опционально, чтобы "make install" работал)
include(GNUInstallDirs)
install(
  TARGETS app
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})

```

- название `.qml` файла должно быть с заглавной буквы(_неточно_)
