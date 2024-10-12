section .data
  exit_code     db      0; Codigo de finalizacion del programa
  sys_call      dq      60; syscall para terminar el programa

section .text
  global    main

main:
  mov     rax,      [sys_call]      ; Se mueve a RAX el código de syscall para Exit()
  mov     rdi,      [exit_code]     ; Se mueve a RDI el código de finalización del programa (0)
  syscall                           ; Se realiza la llamada al sistema operativo
