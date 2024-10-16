
%macro print 1
  mov   rdi, %1
  sub   rsp, 8
  call  printf
  add   rsp, 8
%endmacro

%macro get 1
  mov   rdi, %1
  sub   rsp, 8
  call  gets
  add   rsp, 8
%endmacro


extern printf
extern gets
global main


section .data
  xInputMsg     db    "Ingrese el valor de x: ", 0
  yInputMsg     db    "Ingrese el valor de y: ", 0


section .bss
  xInput    resb  16      
  yInput    resb  16

section .text

main:
  print   xInputMsg
  get     xInput
  print   xInput
  ret 




