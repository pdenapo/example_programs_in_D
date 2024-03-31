#!/bin/sh -v

# Compiling my static library
# Taken from https://renenyffenegger.ch/notes/development/languages/C-C-plus-plus/GCC/create-libraries/index

gcc -c -fPIC my_lib.c
ar rcs my_lib.a my_lib.o
