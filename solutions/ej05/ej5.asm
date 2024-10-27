global main
%include "macros.asm"



section .data
  numbers      dw    0000000000000101b,   
               dw    1111111111111100b,   
               dw    0000000001101001b,   
               dw    1111111110000010b,   
               dw    0000000111101110b,   
               dw    1111110000100000b,   
               dw    0000011110110010b,   
               dw    1110110111100000b,   
               dw    0000111101101010b,   
               dw    1111000001001000b,   
               dw    0001000010100000b,   
               dw    1101010000010001b,   
               dw    0000010110110111b,   
               dw    1100100101011001b,   
               dw    0000011001100110b,   
               dw    1011111111011011b,   
               dw    0000111000101010b,   
               dw    1111111110011100b,   
               dw    0001011100101010b,   
               dw    1110101100010001b    

  numberOfElements      dq    20
  minPosNumber          dw    -32768                              ; - 2 ^ (16 - 1)
  maxPosNumber          dw    32767                               ; 2 ^ (16 - 1) - 1
  counter               dq    0
  msgMin                db    "El número mínimo es: %li", 10, 0   ; hi = 16 bits
  msgMax                db    "El número máximo es: %li", 10, 0
  msgTotal              db    "El total es: %li", 10, 0
  msgAverage            db    "El promedio es: %li", 10, 0
  msgNumber             db    "Numero actual: %hi", 10, 0
  total                 dq    0


section .bss
  minNumber           resq  1
  maxNumber           resq  1
  average             resq  1
  currentNumber       resq  1


section .text
main:
  iterate:
    ; Consigue el número actual
    mov   rax,  qword[counter]
    imul  rax,  rax, 2                  ; Multiplica por 2 para obtener el offset (Corrimiento) (2 bytes por elemento)
    mov   rdx,  numbers
    add   rdx,  rax                     ; Suma el offset a la dirección del vector

    mov   ax,   [rdx]                   ; Guarda el número actual
    
    mov   dword[currentNumber], eax
    
    printArg msgNumber, currentNumber

    ; Arma solución parcial
    sub rsp, 8
    call addToTotal
    call checkForMin
    call checkForMax
    add rsp, 8

    inc qword[counter]
    mov rax, qword[counter]
    cmp rax, [numberOfElements]
    jl  iterate

  sub rsp, 8
  call calculateAverage
  call printResults
  add rsp, 8
  ret


addToTotal:
  mov ax, [currentNumber]
  cwde
  cdqe

  add qword[total], rax
  ret

checkForMin:
  ; Si el número es menor al mínimo actual, salta a assignMin
  mov ax, [currentNumber]
  cwde
  cdqe

  mov rbx, qword[minNumber]

  cmp rax, rbx
  jl  assignMin

  ret
  assignMin:
    mov qword[minNumber], rax
    ret

checkForMax:
  ; Si el número es mayor al máximo actual, salta a assignMax
  mov ax, [currentNumber]
  cwde
  cdqe
  mov rbx, qword[maxNumber]
  cmp rax, rbx
  jg  assignMax
  ret
  assignMax:
    mov qword[maxNumber], rax
    ret

calculateAverage:

  ; Divide el total por la cantidad de números
  mov rax, qword[total]
  mov rbx, qword[numberOfElements]  
  cqo                               ; IMPORTANTE!! Extendemos el signo de rax a rdx
  idiv rbx
  mov qword[average], rax

  ret

printResults:
  ; Imprime los resultados: Mínimo, Máximo, Promedio
  printArg msgTotal, total
  printArg msgMin, minNumber
  printArg msgMax, maxNumber
  printArg msgAverage, average
  ret





    











