section .data
msg1: db "Enter Number of elements: "
len1: equ $-msg1
msg2: db "Ener the Elements of Array: "
len2: equ $-msg2
msg3: db "Enter the Element to be Searched: "
len3: equ $-msg3
msg4: db "Element is found at "
len4: equ $-msg4
msg5: db "Element is Not found "
len5: equ $-msg5
newline: db 0Ah
len6: equ $-newline

section .bss
n: resd 1
n2: resd 1
temp1: resb 1
ar: resd 100
count: resd 1
temp2: resd 1
nod: resb 1

section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov dword[n],0
mov dword[n2],0

read_n:
mov eax,3
mov ebx,0
mov ecx,temp1
mov edx,1
int 80h

cmp byte[temp1],10
je print_msg2

mov eax,dword[n]
mov ebx,10
mul ebx
movzx ebx,byte[temp1]
sub ebx,30h
add eax,ebx
mov dword[n],eax
jmp read_n

print_msg2:

mov ebx,ar
read_array:
push ebx
mov dword[n2],0
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

read_ele:
mov eax,3
mov ebx,0
mov ecx,temp1
mov edx,1
int 80h

cmp byte[temp1],10
je continue_read_arr

mov eax,dword[n2]
mov ebx,10
mul ebx
movzx ebx,byte[temp1]
sub ebx,30h
add eax,ebx
mov dword[n2],eax
jmp read_ele

continue_read_arr:
pop ebx
mov ecx,dword[n2]
mov dword[ebx],ecx
add ebx,32
add dword[count],1
mov ecx,dword[count]
cmp ecx,dword[n]
je print_msg3

jmp read_array

print_msg3:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h

mov dword[n2],0

read_n3:
mov eax,3
mov ebx,0
mov ecx,temp1
mov edx,1
int 80h

cmp byte[temp1],10
je loop_check

mov eax,dword[n2]
mov ebx,10
mul ebx
movzx ebx,byte[temp1]
sub ebx,30h
add eax,ebx
mov dword[n2],eax
jmp read_n3

loop_check:
mov ebx,ar
mov dword[count],0
mov eax, dword[n]
linear:
push eax
cmp eax, dword[count]
je print_msg5

mov ecx, dword[ebx]
cmp ecx, dword[n2]
je print_msg4
add ebx,32
pop eax
add dword[count], 1
jmp linear

print_msg4:
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h

add dword[count],1
mov byte[nod],0

number_extract:
cmp dword[count],0
je print_no
inc byte[nod]
mov edx,0
mov eax,dword[count]
mov ebx,10
div ebx
push edx
mov dword[count],eax
jmp number_extract

print_no:
cmp byte[nod],0
je exit
dec byte[nod]
pop edx
mov dword[temp1],edx
add dword[temp1],30h

mov eax,4
mov ebx,1
mov ecx,temp1
mov edx,1
int 80h
jmp print_no

print_msg5:
mov eax,4
mov ebx,1
mov ecx,msg5
mov edx,len5
int 80h

exit:

mov eax,4
mov ebx,1
mov ecx,newline
mov edx,len6
int 80h

mov eax,1
mov ebx,0
int 80h

