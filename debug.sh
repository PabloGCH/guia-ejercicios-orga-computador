#!/bin/bash

nasm -f elf64 -g -F dwarf -l solutions/$1/$1.lst -o solutions/$1/$1.o solutions/$1/$1.asm
gcc -no-pie -o solutions/$1/$1 solutions/$1/$1.o
gdb solutions/$1/$1
