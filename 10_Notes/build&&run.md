# 📦 Neovim + Qt + CMake: сборка и запуск из Obsidian

## 🧩 Цель

Избавиться от зависимости от Qt Creator и собирать/запускать Qt-проект напрямую из Neovim.

---

## 📁 Структура проекта

Примерная структура проекта после конфигурации в QtCreator:

FileManager/  
├── CMakeLists.txt  
├── build/  
│ └── Desktop-Debug/  
│ ├── FileManager ← скомпилированный бинарник  
│ ├── compile_commands.json  
│ └── ...  
├── main.cpp  
├── mainwindow.ui  
└── ...

---

## ⚙️ Конфигурация CMake (один раз)

```bash
cmake -B build/Desktop-Debug -DCMAKE_BUILD_TYPE=Debug -G Ninja -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

💡 -G Ninja #используется для быстрой сборки.  
💡 compile_commands.json #пригодится для LSP (`clangd`).
```

## 🛠 Настройка сборки в Neovim

Добавить в `init.lua` или в `init.vim`:

```lua
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.makeprg = "cmake --build build/Desktop-Debug"
    vim.opt.errorformat = "%f:%l: %m"
  end,
})
```

### 📦 Сборка проекта

```nvim
:make
```



```bash
cmake .. \
    -G "Unix Makefiles" \
    -DCMAKE_BUILD_TYPE=Debug \
    -DCMAKE_CXX_STANDARD=17 \
    -DCMAKE_PREFIX_PATH=/usr/lib/x86_64-linux-gnu/qt5 \
    -DQT_QMAKE_EXECUTABLE=/usr/lib/x86_64-linux-gnu/qt5/bin/qmake
```
