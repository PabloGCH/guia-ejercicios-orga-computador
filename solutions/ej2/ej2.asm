global main
extern 	printf
extern  gets
extern  sscanf

section .data
  msgFullName       db        "Ingrese nombre y apellido del alumno: ", 0
  msgID             db        "Ingrese el padrón del alumno: ", 0 
  msgBirthDate      db        "Ingrese la fecha de nacimiento del alumno en formato 'dd/mm/yyyy': ", 0
  result            db        "El alumno %s con padrón %s tiene %s años", 0
  dateFormat        db        "%d/%d/%d", 0 ; Format for parsing date
  timeFormat        db        "%d", 0 ; Format for parsing time

section .bss
  fullName      resb      50   ; 50 bytes para el nombre
  id            resb      6    ; 6 bytes para el padrón
  date          resb      10   ; 10 bytes para la fecha
  age           resb      3    ; 3 bytes para la edad
  dayOfBirth    resb      2    ; 2 bytes para el día de nacimiento
  monthOfBirth  resb      2    ; 2 bytes para el mes de nacimiento
  yearOfBirth   resb      4    ; 4 bytes para el año de nacimiento

section .text

main:
  sub     rsp,    8     ; Corro el puntero a la pila 8 bytes para que el call de la sscanf
                        ; deje rsp en una dir multiplo de 16

;nameInput:
;  mov     rdi,    msgFullName
;  call    printf
;
;  mov     rdi,    fullName 
;  call    gets
;
;
;idInput:
;  mov     rdi,    msgID
;  call    printf
;
;  mov     rdi,    id
;  call    gets


dateInput:
  mov     rdi,    msgBirthDate
  call    printf

  mov     rdi,    date
  call    gets


parseDate:
  mov     rdi,    date
  mov     rsi,    dateFormat
  mov     rdx,    dayOfBirth
  mov     rcx,    monthOfBirth
  mov     r8,     yearOfBirth
  call    sscanf



;resultOutput:
;  mov     rdi,    result
;  mov     rsi,    fullName 
;  mov     rdx,    id
;  call    printf

end:
  add     rsp,    8   ; Restauro rsp a su valor original
  ret     


