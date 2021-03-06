section .data
  msg1: db "system is little endian",0Ah
  size1: equ $-msg1
  msg2: db "system is big endian",0Ah
  size2: equ $-msg2

section .bss
  temp: resb 1

section .text
  global _start
 _start:

  mov eax, 0xffff0000
  push eax
 pop ax
  pop bx
  
  cmp bx, 0xffff
  je  little_endian
  jmp big_endian
little_endian:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h
  jmp exit
big_endian:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, size2
  int 80h
  jmp exit



exit:
  mov eax, 1
  mov ebx, 0
  int 80h

