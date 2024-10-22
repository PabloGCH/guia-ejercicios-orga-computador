global main
%include "macros.asm"



section .data
  numbers      dw    0000000000000101b,   ; 5
               dw    1111111111111100b,   ; -4
               dw    0000000001101001b,   ; 105
               dw    1111111110000010b,   ; -126
               dw    0000000111101110b,   ; 494
               dw    1111110000100000b,   ; -1984
               dw    0000011110110010b,   ; 1970
               dw    1110110111100000b,   ; -3552
               dw    0000111101101010b,   ; 3946
               dw    1111000001001000b,   ; -2864
               dw    0001000010100000b,   ; 4128
               dw    1101010000010001b,   ; -11055
               dw    0000010110110111b,   ; 1463
               dw    1100100101011001b,   ; -15575
               dw    0000011001100110b,   ; 1638
               dw    1011111111011011b,   ; -16453
               dw    0000111000101010b,   ; 1762
               dw    1111111110011100b,   ; -100
               dw    0001011100101010b,   ; 7442
               dw    1110101100010001b    ; -4767

  numberOfElements      dq    20
  minPosNumber             dw    -32768                ; - 2 ^ (16 - 1)
  maxPosNumber             dw    32767                 ; 2 ^ (16 - 1) - 1
  counter               dq    0
  msgMin                db    "El número mínimo es: %hi", 10, 0   ; hi = 16 bits
  msgMax                db    "El número máximo es: %hi", 10, 0
  msgAverage            db    "El promedio es: %hi", 10, 0
  msgNumber             db    "%hi", 10, 0


section .bss
  minNumber           resq  1
  maxNumber           resq  1
  total               resq  1
  average             resq  1
  currentNumber       resq  1


section .text
main:
  iterate:
    ; Consigue el número actual
    mov rax, qword[counter]
    imul rax, rax, 2          ; Multiplica por 2 para obtener el offset (Corrimiento) (2 bytes por elemento)
    mov rdx, numbers
    add rdx, rax              ; Suma el offset a la dirección del vector

    mov eax, [rdx]            ; Guarda el número actual
    mov dword[currentNumber], eax

    printArg msgNumber, currentNumber

    ; Arma solución parcial
    call addToTotal
    call checkForMin
    call checkForMax

    inc qword[counter]
    mov rax, qword[counter]
    cmp rax, [numberOfElements]
    jl  iterate

  call calculateAverage
  call printResults
  ret


addToTotal:
  ret

checkForMin:
  ; Si el número es menor al mínimo actual, salta a assignMin
  ret
  assignMin:
    ret

checkForMax:
  ; Si el número es mayor al máximo actual, salta a assignMax
  ret
  assignMax:
    ret

calculateAverage:
  ; Divide el total por la cantidad de números
  ret

printResults:
  ; Imprime los resultados: Mínimo, Máximo, Promedio
  ret





    











