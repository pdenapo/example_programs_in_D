#!/bin/sh -v

# Compiling my static library
# Taken from https://renenyffenegger.ch/notes/development/languages/C-C-plus-plus/GCC/create-libraries/index

gcc -c -fPIC my_lib.c
gcc -shared  my_lib.o -o libmy_lib.so
