section .data
msg1: db "Enter a String",0Ah
len1: equ $-msg1
msg2: db "length is "
len2: equ $-msg2
msg3: db 0Ah
len3: equ $-msg3


section .bss
ar: resb 100
count: resb 1
temp: resb 1
nod: resb 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
mov eax,ar

read_arr:
push eax
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read

inc byte[count]
pop eax
mov bl,byte[temp]
mov byte[eax],bl
add eax,1
jmp read_arr

end_read:
pop eax
mov byte[eax],0
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

extract_no:
    cmp byte[count], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    mov al, byte[count]
    mov ebx, 10
    div ebx
    push edx
    mov byte[count], al
    jmp extract_no

  print_no:
    cmp byte[nod], 0
    je print_arr
    dec byte[nod]
    pop edx
    mov byte[temp], dl
    add byte[temp], 30h


    mov eax, 4
    mov ebx, 1
    mov ecx, temp
    mov edx, 1
    int 80h
    
    jmp print_no

print_arr:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
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

