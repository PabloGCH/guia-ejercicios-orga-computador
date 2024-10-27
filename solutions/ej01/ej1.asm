global main
extern puts

section .data
  message db "Organizacion del Computador", 0

section .text
main:
  mov   rdi,    message
  call  puts
  ret
