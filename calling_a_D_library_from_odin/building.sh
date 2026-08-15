cd mylib
dub build
cd ..
odin build . -extra-linker-flags:"-lphobos2 -pthread"

