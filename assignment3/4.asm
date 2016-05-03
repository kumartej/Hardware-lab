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
start: db 0
end: db 0

section .bss
ar: resb 100
count: resb 1
temp: resb 1
nod: resb 1
spct: resb 1
str1: resb 100
str2: resb 100
str3: resb 100
lens1: resb 1
lens2: resb 1
lens3: resb 1
compval: resb 1

section .text
global _start:
_start:


cld
mov edi,str1
call readarray
mov al,byte[count]
mov byte[lens1],al
mov edi,str2
call readarray
mov al,byte[count]
mov byte[lens2],al
mov edi,str3
call readarray
mov al,byte[count]
mov byte[lens3],al

mov al,byte[lens2]
cmp al,byte[lens1]
jg print_array1
;sub al,byte[lens2]
mov byte[start],0
mov byte[end],al
sub byte[end],1
;add al,1
for1:
mov cl,byte[lens1]
cmp cl,byte[end]
jl print_rest
call stringcompare
cmp byte[compval],1
je print_string3
jmp print_char
print_string3:
mov eax,str3
call printarray
mov al,byte[end]
add al,1
mov byte[start],al
mov al,byte[lens2]
add byte[end],al
jmp for1
print_char:
mov eax,str1
movzx edx,byte[start]
add eax,edx
mov dl,byte[eax]
mov byte[temp],dl
pusha
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
popa
add byte[start],1
add byte[end],1
jmp for1

print_array1:
mov eax,str1
call printarray
jmp exit

print_rest:
cmp cl,byte[start]
jl exit
mov eax,str1
movzx ebx,byte[start]
add eax,ebx
call printarray
jmp exit

exit:
call printnull
mov eax,1
mov ebx,0
int 80h

stringcompare:
pusha
mov eax,str1
mov ebx,str2
movzx ecx,byte[start]
mov edi,str2
add eax,ecx
mov esi,eax
mov cl,byte[start]
cld
str_cmp_loop:
cmp cl,byte[end]
jg return1
cmpsb
jne return0
add cl,1
jmp str_cmp_loop
return1:
mov byte[compval],1
popa
ret
return0:
mov byte[compval],0
popa
ret

readarray:
pusha
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h
mov byte[count],0
read_arr:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read

inc byte[count]
mov al,byte[temp]
cld
stosb
jmp read_arr
end_read:
mov al,0
stosb
popa
ret

printarray:
pusha
print_arr:
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
je afterprint
jmp cont_print

afterprint:
popa
ret

printnull:
pusha
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h
popa
ret
