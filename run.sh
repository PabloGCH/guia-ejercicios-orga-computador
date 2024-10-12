#!/bin/bash

nasm solutions/$1/$1.asm -f elf64 -o solutions/$1/$1.o
gcc solutions/$1/$1.o -o solutions/$1/$1.out -no-pie
chmod +x solutions/$1/$1.out
./solutions/$1/$1.out
