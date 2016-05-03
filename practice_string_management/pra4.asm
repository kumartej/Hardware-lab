section .data
msg1: db "Enter a String",0Ah
len1: equ $-msg1
msg2: db "length is "
len2: equ $-msg2
msg3: db 0Ah
len3: equ $-msg3
space: db " "
msg4: db 0Ah
len4: equ $-msg4


section .bss
ar: resb 100
count: resb 1
temp: resb 1
nod: resb 1
spct: resb 1

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
mov bl,byte[count]
mov byte[nod],0
mov eax,ar
mov byte[spct],0

count_space:
cmp bl,byte[nod]
je print_count

mov cl,byte[eax]
cmp cl,20h
je inc_space
add eax,1
add byte[nod],1
jmp count_space
inc_space:
add byte[spct],1
add eax,1
add byte[nod],1
jmp count_space

print_count:
mov byte[nod],0
cmp byte[spct],0
je zeroprint
extract_no:
    cmp byte[spct], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    movzx eax, byte[spct]
    mov ebx, 10
    div ebx
    push edx
    mov byte[spct], al
    jmp extract_no

  print_no:
    cmp byte[nod], 0
    je exit
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

zeroprint:
mov byte[spct],48

mov eax,4
mov ebx,1
mov ecx,spct
mov edx,1
int 80h
jmp exit
exit:
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h
mov eax,1
mov ebx,0
int 80h
