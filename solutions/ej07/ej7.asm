; Dada una matriz de 3x3 de números almacenados en BPF c/s de 16 bits
; calcule la traza e imprimirla por pantalla.

global main
%include "macros.asm"


section .data
  matrix      dw    1, 2, 3, 4, 5, 6, 7, 8, 9
  msgTrace    db    "El resultado de la traza es: %li", 10, 0
  trace       dq    0

section .text
main:
  mov   rbx,  0   ; Indice de fila
  mov   rcx,  0   ; Indice de columna

  iterate:
    mov   rdx, matrix             ; Guarda la dirección de la matriz
    mov   rax, rbx                ; Guarda el índice de fila
    imul  rax, 3                  ; Multiplica el índice de fila por 3 (3 elementos por fila)
    imul  rax, 2                  ; Multiplica el índice de fila por 2 (2 bytes por elemento)
    add   rdx, rax                ; Suma el índice de fila a la dirección de la matriz
    mov   rax, rcx                ; Guarda el índice de columna
    imul  rax, 2                  ; Multiplica el índice de columna por 2 (2 bytes por elemento)
    add   rdx, rax                ; Suma el índice de columna a la dirección de la matriz
    
    mov   ax, [rdx]               ; Guarda el número actual
    cwde                          ; Extiende el número a 32 bits
    cdqe                          ; Extiende el número a 64 bits

    add   qword[trace], rax       ; Suma el número actual a la traza

    inc   rbx                     ; Incrementa el índice de fila
    inc   rcx                     ; Incrementa el índice de columna

    cmp   rbx, 3                  ; Compara el índice de fila con 3
    jl    iterate                 ; Si el índice de fila es menor a 3, repite el ciclo

  printResult:
    printArg  msgTrace, trace     ; Imprime la traza
  ret




