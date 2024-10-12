extern puts

section .data
  cadena db "Hola", 0

section .text
  global main


main:
  mov rdi,   cadena   ; Paso la posicion de inicio del String
  sub rsp,   0x28     ; Reservo 40 bytes (32+8) para reservar 32 bytes
                      ; de shadow space (necesario en windows) y agrego 8
                      ; bytes para que sumado a los 8 bytes de la posicion de
                      ; retorno de puts sea un total de 48 bytes y el stack
                      ; quede alineado a un multiplo de 16 bytes (16x3=48)

llamada:
  call puts           ; Invoco a la funcion PUTS de C
  add rsp, 0x28       ; Recupero el espacio reservado
fin:
  ret                 ; Cierre del programa principal
