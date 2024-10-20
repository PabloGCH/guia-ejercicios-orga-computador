global main
%include "macros.asm"


section .data
  xInputMsg       db    "Ingrese el valor de x: ", 0
  yInputMsg       db    "Ingrese el valor de y: ", 0
  resultMsgPos    db    "El resultado es: %li", 10, 0
  resultMsgNeg    db    "El resultado es: 1/%li", 10, 0
  format          db    "%li", 0


section .bss
  xValue      resq 1
  yValue      resq 1
  result      resq 1
  buffer      resb 100


section .text
main:
  read xInputMsg, buffer, format, xValue
  read yInputMsg, buffer, format, yValue
  ret

