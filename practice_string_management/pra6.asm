section .data
msg1:db "enter string",0Ah
len1:equ $-msg1
msg2:db 0Ah,"given string is:"
len2:equ $-msg2
msg3:db "size of string:"
len3:equ $-msg3
msg4: db 0Ah
len4: equ $-msg4


global _start:
 _start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov ebx,arr
mov word[size],0
reading_string:
push ebx
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
cmp byte[temp],10
je end_reading
pop ebx
cmp byte[temp],'A'
je reading_string
cmp byte[temp],'I'
je reading_string
mov al,byte[temp]
mov byte[ebx],al
add ebx,1
add word[size],1
jmp reading_string

end_reading:
pop ebx
mov byte[ebx],0

mov eax,arr
mov ebx,arr
check:
cmp byte[ebx],0
je end_check
cmp byte[ebx],'A'
je continue
cmp byte[ebx],'I'
je continue
mov cl,byte[ebx]
mov byte[ebx],cl
inc eax
inc ebx
jmp check
continue:
inc ebx
jmp check



end_check:
mov byte[eax],0
mov ebx,arr

print_string:
cmp byte[ebx],0
je end_printing
mov al,byte[ebx]

push ebx
mov byte[temp],al
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
pop ebx
add ebx,1
jmp print_string

end_printing:

mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h

mov eax,1
mov ebx,0
int 80h





section .bss
arr: resb 100
size:resw 1
temp:resb 1
pnum:resw 1
nod :resb 1
