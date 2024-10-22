global main
%include "macros.asm"



section .data
  numbers               dw    0000 0000 0000 0101   ; 5
                              1111 1111 1111 1100   ; -4
                              0000 0000 0110 1001   ; 105
                              1111 1111 1000 0010   ; -126
                              0000 0001 1110 1110   ; 494
                              1111 1100 0010 0000   ; -1984
                              0000 0111 1011 0010   ; 1970
                              1110 1101 1110 0000   ; -3552
                              0000 1111 0110 1010   ; 3946
                              1111 0000 0100 1000   ; -2864
                              0001 0000 1010 0000   ; 4128
                              1101 0100 0001 0001   ; -11055
                              0000 0101 1011 0111   ; 1463
                              1100 1001 0101 1001   ; -15575
                              0000 0110 0110 0110   ; 1638
                              1011 1111 1101 1011   ; -16453
                              0000 1110 0010 1010   ; 1762
                              1111 1111 1001 1100   ; -100
                              0001 0111 0010 1010   ; 7442
                              1110 1011 0001 0001   ; -4767

  numberOfElements      dq    20
  minNumber             dw    -32768                ; - 2 ^ (16 - 1)
  maxNumber             dw    32767                 ; 2 ^ (16 - 1) - 1
  counter               dq    0
  msgMin                db    "El número mínimo es: %i", 10, 0
  msgMax                db    "El número máximo es: %i", 10, 0
  msgAverage            db    "El promedio es: %i", 10, 0


section .bss
  minNumber           resq  1
  maxNumber           resq  1
  total               resq  1
  average             resq  1


section .text
main:
  iterate:
    inc qword[counter]
    mov rax, qword[counter]
    cmp rax, [numberOfElements]
    jl  iterate
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





    











