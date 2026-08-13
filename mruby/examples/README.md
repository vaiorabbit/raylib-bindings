# How to run your mruby game codes

*   Created : 2026-08-12
*   Last modified : 2026-08-13

## Use raylib-enabled mruby.exe

```
> bin/host/bin/mruby.exe code_pacone.rb
```

## Compile source into bytecode

```
> bin/host/bin/mrbc.exe -o  code_pacone.mrb code_pacone.rb
> bin/host/bin/mruby.exe -b code_pacone.mrb
```

## Read code as a string and pass it to the mruby interpreter API

```
> cd string
> cmake -B build -S . -G "Visual Studio 18 2026"
> cmake --build .\build --config Release
> .\build\Release\code_pacone.exe .\code_pacone.rb
```

## Call Ruby methods from C

```
> cd funcall
> cmake -B build -S . -G "Visual Studio 18 2026"
> cmake --build .\build --config Release
> .\build\Release\code_pacone.exe .\code_pacone.rb
```

## Embed into C source

```
> bin\host\bin\mrbc.exe -o embedding\code_pacone.h -s -Bcode_pacone code_pacone.rb
> cd embedding
> cmake -B build -S . -G "Visual Studio 18 2026"
> cmake --build .\build --config Release
> .\build\Release\code_pacone.exe
```

## Build for web browser

```
> bin\host\bin\mrbc.exe -o web\code_pacone.h -s -Bcode_pacone code_pacone.rb
> cd web
> emcmake cmake -B build -S . -G "NMake Makefiles"
> cmake --build .\build --config Release
> python -m http.server

(from another console)
> start http://localhost:8000/build/code_pacone.html
```
