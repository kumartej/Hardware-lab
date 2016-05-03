section .data
msg1: db "Enter a String",0Ah
len1: equ $-msg1
msg2: db "equal",0Ah
len2: equ $-msg2
msg3: db "Not equal",0Ah
len3: equ $-msg3
space: db " "
msg4: db 0Ah
len4: equ $-msg4


section .bss
ar1: resb 100
count1: resb 1
temp: resb 1
nod: resb 1
ar2: resb 100
count2: resb 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
mov eax,ar1

read_arr1:
push eax
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read1

inc byte[count1]
pop eax
mov bl,byte[temp]
mov byte[eax],bl
add eax,1
jmp read_arr1

end_read1:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
mov byte[count2],0

mov eax,ar2
read_arr2:
push eax
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read2

inc byte[count2]
pop eax
mov bl,byte[temp]
mov byte[eax],bl
add eax,1
jmp read_arr2

end_read2:
mov al,byte[count1]
cmp al,byte[count2]
jne print_no
mov byte[nod],0
mov ebx,ar1
mov ecx,ar2

check_equal:
cmp al,byte[nod]
je print_yes
mov dl,byte[ebx]
cmp dl,byte[ecx]
jne print_no
add byte[nod],1
add ebx,1
add ecx,1
jmp check_equal

print_yes:
mov dl,byte[ar1]
cmp dl,byte[ar2]
jne print_no
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h
jmp exit

print_no:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
jmp exit

exit:
mov eax,1
mov ebx,0
int 80h
