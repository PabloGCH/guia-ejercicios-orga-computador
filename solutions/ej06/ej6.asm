;Dado un vector de 30 números decimales (positivos/negativos) se pide escribir un programa que invierta el vector
;es decir, el último elemento queda en el primer lugar, el anteúltimo en el segundo, etc.

global main
%include "macros.asm"


section .data
  vector      dd    1, 2, 3, 4, 5, 6, 7, 8, 9, 10, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
  msgNumber   db    "%d", 10, 0

section .bss
  newVector   resd  30
  result      resd  1



section .text
main:
  mov   rbx,  30    ; Indice del vector original (Empieza en el último elemento)
  mov   rcx,  0     ; Indice del nuevo vector    (Empieza en el primer elemento)

  iterate:
    mov   eax,  [vector + (rbx - 1) * 4]          ; Guarda el número actual
    mov   [newVector + rcx * 4], eax        ; Guarda el número actual en el nuevo vector
    inc   rcx                               ; Incrementa el índice del nuevo vector
    dec   rbx                               ; Decrementa el índice del vector original
    cmp   rbx, 0                            ; Compara el índice del vector original con 0
    jg    iterate                           ; Si el índice del vector original es mayor a 0, repite el ciclo
  
  mov   rbx, 0
  printElement:
    mov       eax, [newVector + rbx * 4]        ; Guarda el número actual
    mov       [result], eax                     ; Guarda el número actual en la variable result
    printArg  msgNumber, result              ; Imprime el número actual
    inc       rbx                               ; Decrementa el índice del vector
    cmp       rbx, 30                           ; Compara el índice del vector con 30
    jl        printElement                      ; Si el índice del vector es menor a 30, repite el ciclo
  ret








