global main
extern printf
%include "macros.asm"

section .data
  msg             db      "Ingrese un numero: ", 0
  format          db      "%li", 0
  msgInput        db      "Ingreso: %li", 10, 0
  iterations      dq      0

section .bss
  buffer          resb    100
  number          resq    1
  numberVector    times 4 resq 1


section .text

main:
  iterate:
    read  msg, buffer, format, number
    mov   rax, [number]       ; Nuevo número

    mov   rdx, numberVector   ; Dirección del vector
    mov   rcx, [iterations]   ; Iteración, indice del vector
    imul  rcx, rcx, 8         ; Multiplicamos por 8 para obtener el offset (Corrimiento) (8 bytes por número)
    add   rdx, rcx            ; Sumamos el offset a la dirección del vector
    mov   [rdx], rax          ; Guardamos el número en el vector
    
    inc qword[iterations]
    cmp qword[iterations], 4
    jl iterate

  mov qword[iterations], 0
  printAll:
    mov   rdx, numberVector   ; Dirección del vector
    mov   rcx, [iterations]   ; Iteración, indice del vector
    imul  rcx, rcx, 8         ; Multiplicamos por 8 para obtener el offset (Corrimiento) (8 bytes por número)
    add   rdx, rcx            ; Sumamos el offset a la dirección del vector

    printArg msgInput, rdx

    inc qword[iterations]
    cmp qword[iterations], 4
    jl printAll
  ret
    
    




