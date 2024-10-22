global main
extern printf
%include "macros.asm"

section .data
  msg               db      "Ingrese un numero: ", 0
  format            db      "%li", 0
  msgInput          db      "Ingreso: %li", 10, 0
  counter           dq      0
  auxCounter        dq      0
  numberOfElements  dq      4
  swapped           dq      0


section .bss
  buffer                  resb    100
  number                  resq    1
  numberVector            times   4 resq 1 ; IMPORTANTE: TIMES DEBE SER IGUAL A numberOfElements
  currentNumberAddress    resq 1
  nextNumberAddress       resq 1



section .text

main:
  ;INGRESO DE DATOS
  iterate:
    read  msg, buffer, format, number
    mov   rax, [number]       ; Nuevo número

    mov   rdx, numberVector   ; Dirección del vector
    mov   rcx, [counter]      ; Iteración, indice del vector
    imul  rcx, rcx, 8         ; Multiplicamos por 8 para obtener el offset (Corrimiento) (8 bytes por número)
    add   rdx, rcx            ; Sumamos el offset a la dirección del vector
    mov   [rdx], rax          ; Guardamos el número en el vector
    
    ; Si quedan elementos por ingresar, continua
    mov rax, [numberOfElements]
    inc qword[counter]
    cmp qword[counter], rax
    jl iterate

  ;ORDENAMIENTO
  mov qword[counter], 0
  firstLoop:
    mov qword[swapped], 0
    mov qword[auxCounter], 0
    secondLoop:
      ;Logica de swap
      ;--------------------------------
      ; Si no se hay que intercambiar se saltea el swap
      swap:
        ;------- Consigue primer número ------------
        mov   rdx, numberVector                   ; Dirección del vector    
        mov   rcx, [auxCounter]                   ; Iteración, indice del vector
        imul  rcx, rcx, 8                         ; Multiplicamos por 8 para obtener el offset (Corrimiento) (8 bytes por número)
        add   rdx, rcx                            ; Sumamos el offset a la dirección del vector
        ;--------------------------------
        mov   rax, [rdx]                          ; Guardo el número actual
        mov   qword[currentNumberAddress], rdx    ; Guardo la dirección del número actual
        ;------- Consigue segundo número ------------
        mov   rdx, numberVector                   ; Dirección del vector
        mov   rcx, [auxCounter]                   ; Iteración, indice del vector
        inc   rcx                                 ; Siguiente número
        imul  rcx, rcx, 8                         ; Multiplicamos por 8 para obtener el offset (Corrimiento) (8 bytes por número)
        add   rdx, rcx                            ; Sumamos el offset a la dirección del vector
        ;--------------------------------
        mov   rbx, [rdx]                          ; Guardo el número siguiente
        mov   qword[nextNumberAddress], rdx       ; Guardo la dirección del número siguiente
        ;------- Compara los números ------------
        cmp   rax, rbx                            ; Compara los números
        jge   endOfSecondLoopIteration            ; Si no se deben intercambiar, termina (Esta ordenando de mayor a menor)
        ;------- Intercambia los números ------------
        mov   qword[swapped],               1
        mov   rdx, [currentNumberAddress]
        mov   [rdx],  rbx                         ; Guarda el número siguiente en la dirección del número actual
        mov   rdx, [nextNumberAddress]
        mov   [rdx],  rax                         ; Guarda el número actual en la dirección del número siguiente
      endOfSecondLoopIteration:
        ;Si no termino el segundo loop, Continua
        mov   rax, [numberOfElements]
        dec   rax ; Decrementa rax ya que no queremos iterar con el ultimo valor (no tiene siguiente)
        inc   qword[auxCounter]
        cmp   qword[auxCounter], rax
        jl    secondLoop
    ;Si no se hizo ningun swap, termina
    cmp qword[swapped], 0
    je printAll
    ;Si no termino el primer loop, Continua
    mov rax, [numberOfElements]
    inc qword[counter]
    cmp qword[counter], rax
    jl firstLoop
    jmp printAll
 

  printAll:
    ;IMPRESION DE RESULTADOS
    mov qword[counter], 0
    printNext:
      mov   rdx, numberVector   ; Dirección del vector
      mov   rcx, [counter]   ; Iteración, indice del vector
      imul  rcx, rcx, 8         ; Multiplicamos por 8 para obtener el offset (Corrimiento) (8 bytes por número)
      add   rdx, rcx            ; Sumamos el offset a la dirección del vector

      printArg msgInput, rdx
      
      mov rax, [numberOfElements]
      inc qword[counter]
      cmp qword[counter], rax
      jl printNext
  ret
    
    




