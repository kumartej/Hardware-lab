section .data
msg1: db "Enter a String",0Ah
len1: equ $-msg1
msg2: db "length is "
len2: equ $-msg2
msg3: db "yes",0Ah
len3: equ $-msg3
msg4: db "no",0Ah
len4: equ $-msg4


section .bss
ar: resb 100
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

movzx eax,byte[count]
mov ebx,2
div ebx
mov byte[mid],al
mov eax,ar
mov byte[c1],0
mov bl,byte[mid]
mov edx,ar
movzx ecx,byte[count]
add edx,ecx
sub edx,1

check_palin:
cmp bl,byte[c1]
je print_yes

mov cl,byte[edx]
cmp cl,byte[eax]
je con_check
jmp print_no
con_check:
add byte[c1],1
add eax,1
sub edx,1
jmp check_palin

print_yes:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
jmp exit

print_no:
mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h

exit:
mov eax,1
mov ebx,0
int 80h
