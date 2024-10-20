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
  counter     resq 1


section .text
main:
  ;Consigue los valores de x e y
  read xInputMsg, buffer, format, xValue
  read yInputMsg, buffer, format, yValue

  sub rsp, 8
  ;Inicializa el contador
  call initCounter
  ;Calcula la potencia
  call powerOf
  ;Imprime el resultado
  call printResult
  add rsp, 8
  ret




;INICIALIZACION DE CONTADOR
initCounter:
  mov rax, [yValue]
  mov qword[counter], rax

  cmp qword[counter], 0
  jl changeCounterSign
    ret

  changeCounterSign:
    mov rax, [counter]
    neg rax
    mov [counter], rax
    ret

; CALCULO DE POTENCIA
powerOf:
  mov rax, [xValue]
  mov rbx, [xValue]

  multiply:
    imul rax, rbx
    dec qword[counter]
    cmp qword[counter], 1
    jg multiply

  mov qword[result], rax
  ret

; IMPRESION DE RESULTADO

printResult:
  cmp qword[yValue], 0
  jl printNegative
    printArg resultMsgPos, result
    ret

  printNegative:
    printArg resultMsgNeg, result
    ret






