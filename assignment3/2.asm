section .data
msg1: db "Enter a String",0Ah
len1: equ $-msg1
msg2: db "length is "
len2: equ $-msg2
msg3: db 0Ah
len3: equ $-msg3
carr: times 130 db 0

section .bss
ar: resb 100
count: resb 1
temp: resb 1
nod: resb 1
char: resb 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov ebx,carr
mov edi,ar

read_arr:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read

mov ebx,carr
movzx eax,byte[temp]
add ebx,eax
cmp byte[ebx],0
jg read_arr
inc byte[count]
mov al,byte[temp]
cld
stosb
add byte[ebx],1
jmp read_arr

end_read:

print_arr:
mov eax,ar
mov bl,byte[eax]
mov byte[temp],bl

cont_print:
push eax
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h

pop eax
add eax,1
mov bl,byte[eax]
mov byte[temp],bl
cmp byte[temp],0
je exit
jmp cont_print

exit:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
mov eax,1
mov ebx,0
int 80h

