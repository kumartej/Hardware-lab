section .data
msg1: db "Enter a String",0Ah
len1: equ $-msg1
msg2: db "words in reversed order",0Ah
len2: equ $-msg2
msg3: db " "
len3: equ $-msg3
msg4: db 0Ah
len4: equ $-msg4
msg5: db "Enter another String to Concat",0Ah
len5: equ $-msg5

section .bss
cpy: resb 20
ar: resb 400
nword: resb 1
i: resb 1
j: resb 1
temp: resb 1
nod: resb 1
count: resb 1
check: resb 1
lenw: resb 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov byte[nword],0
mov edi,ar
mov eax,ar
call scan_string

;mov eax,ar
;call print_string

mov eax,ar
mov ebx,ar
mov byte[i],0
mov byte[j],0


for_i:
   mov cl,byte[i]
   cmp cl,byte[nword]
   je after_fori

      call swap_str
      add eax,15
      add byte[i],1
      jmp for_i
   

pusha
   mov eax,4
   mov ebx,1
   mov ecx,msg2
   mov edx,len2
   int 80h
   popa

after_fori:
   mov eax,4
   mov ebx,1
   mov ecx,msg2
   mov edx,len2
   int 80h

   mov eax,ar
   call print_string

exit:
call printnull
mov eax,1
mov ebx,0
int 80h

string_compare:
   pusha
        mov esi,eax
        mov edi,ebx
        mov ecx, 15
        repe cmpsb
	dec esi
	dec edi
	mov al, byte[esi]
	mov ah, byte[edi]
	cmp al, ah
	jg return0
   return1:
      mov byte[check],1
      popa
      ret
   return0:
      mov byte[check],0
      popa
      ret   

swap_str:
   pusha
   call len_str
   mov edi,cpy
   mov esi,eax
   movzx ecx,byte[lenw]
   rep movsb
   
   mov esi,cpy
   movzx ecx,byte[lenw]
   add esi,ecx
   dec esi
   mov edi,eax
   mov cl,0
   f2:
      cmp cl,byte[lenw]
      je after_f2
      movsb
      dec esi
      dec esi
      add cl,1
      jmp f2
   
   after_f2:
   popa
   ret

len_str:
   pusha
   mov cl,0
   f1:
     cmp cl,15
     je after_f1
     cmp byte[eax],0
     je after_f1
     inc eax
     inc cl
     jmp f1
   after_f1:
     mov byte[lenw],cl
     popa
   ret

scan_string:
push eax
mov byte[count],0
read_ar:
    mov eax,3
    mov ebx,0
    mov ecx,temp
    mov edx,1
    int 80h
    
    cmp byte[temp],10
    je after_read
    
    cmp byte[temp],32
    je after_space
    
    inc byte[count]
    mov al,byte[temp]
    cld
    stosb
    jmp read_ar

after_space:
    pop eax
    cmp byte[count],15
    jl no_reset
    
    mov byte[count],14
no_reset:
    movzx ebx,byte[count]
    mov ecx,eax
    add ecx,ebx
    mov byte[ecx],0
    add eax,15
    mov edi,eax
    mov byte[count],0
    inc byte[nword]
    push eax
    jmp read_ar
after_read:
    pop eax
    cmp byte[count],15
    jl no_reset1
    
    mov byte[count],14
no_reset1:
    movzx ebx,byte[count]
    mov ecx,eax
    add ecx,ebx
    mov byte[ecx],0
    inc byte[nword]
    add eax,15
ret

print_string:
pusha
    mov byte[count],0
    print_ar:
        mov cl,byte[nword]
        cmp byte[count],cl
        je end_print_string
        mov cl,byte[eax]
        mov byte[temp],cl
	mov ebx,eax

        cont_print:
           pusha
           mov eax,4
           mov ebx,1
           mov ecx,temp
           mov edx,1
           int 80h

           popa
           add eax,1
           mov cl,byte[eax]
           mov byte[temp],cl
           cmp byte[temp],0
           je afterprint
           jmp cont_print
        afterprint:
           add ebx,15
           mov eax,ebx
           inc byte[count]
           call print_space
        jmp print_ar
    end_print_string:
        popa
        ret

print_space:
pusha
    mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,len3
    int 80h
popa
ret

printnull:
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,len4
    int 80h
ret
