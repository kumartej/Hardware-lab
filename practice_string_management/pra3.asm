section .data
msg1: db "Enter String1",0Ah
len1: equ $-msg1
msg2: db "Enter String2 ",0Ah
len2: equ $-msg2
msg3: db "concatnated String",0Ah
len3: equ $-msg3
msg4: db 0Ah
len4: equ $-msg4


section .bss
ar: resb 200
ar2:resb 100
count: resb 1
temp: resb 1
nod: resb 1
mid: resb 1
c1: resb 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
mov eax,ar
mov byte[count],0
mov byte[c1],0

read_arr:
push eax
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read_arr1

inc byte[count]
pop eax
mov bl,byte[temp]
mov byte[eax],bl
add eax,1
jmp read_arr

end_read_arr1:
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

mov eax,ar2

read_arr2:
push eax
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read_arr2

inc byte[c1]
pop eax
mov bl,byte[temp]
mov byte[eax],bl
add eax,1
jmp read_arr2

end_read_arr2:

mov eax,ar
movzx ebx,byte[count]
add eax,ebx
mov edx,ar2
mov byte[mid],0
movzx ebx,byte[c1]
;sub bl,1

concat:
cmp bl,byte[mid]
je print_ar1
mov cl,byte[edx]
mov byte[eax],cl
add eax,1
add edx,1
add byte[mid],1
jmp concat

print_ar1:
mov byte[eax],0
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
mov ecx,msg4
mov edx,len4
int 80h
mov eax,1
mov ebx,0
int 80h

