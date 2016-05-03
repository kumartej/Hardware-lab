section .data
msg1: db "Enter a Number",0Ah
len1: equ $-msg1
msg2: db "gcd: "
len2: equ $-msg2
msg3: db 0Ah
len3 equ $-msg3
msg4: db "INVALID INPUT",0Ah
len4: equ $-msg4

section .bss
temp: resb 1
num1: resd 1
num2: resd 1
c1: resb 1
c2: resb 1
number1: resd 1
sum: resd 1
nod: resb 1

section .text
global _start:
_start:
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov dword[number1],0
call scan_number
mov eax,dword[number1]
mov dword[num1],eax

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

mov dword[number1],0
call scan_number
mov eax,dword[number1]
mov dword[num2],eax

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

call gcd_2num

exit:
mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,len3
int 80h

mov eax,1
mov ebx,0
int 80h

gcd_2num:
    mov ebx,dword[num2]
    cmp ebx,0
    je end_gcd
    
    mov eax,dword[num1]
    mov edx,0
    mov ebx,dword[num2]
    div ebx
    mov eax,dword[num2]
    mov dword[num1],eax
    mov dword[num2],edx
    call gcd_2num
    ret
    
    end_gcd:
    mov eax,dword[num1]
    mov dword[sum],eax
    call print_number
    ret

scan_number:
pusha

    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp byte[temp],45
    je loop_read
    
    cmp byte[temp],48
    jl print_invalid
    
    cmp byte[temp],57
    jg print_invalid
    
    mov eax, dword[number1]
    mov ebx, 10
    mul ebx
    movzx ebx, byte[temp]
    sub ebx, 30h
    add eax, ebx
    mov dword[number1], eax

loop_read:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp byte[temp], 10
    je after_read
    
    cmp byte[temp],48
    jl print_invalid
    
    cmp byte[temp],57
    jg print_invalid
    
    mov eax, dword[number1]
    mov ebx, 10
    mul ebx
    movzx ebx, byte[temp]
    sub ebx, 30h
    add eax, ebx
    mov dword[number1], eax
    jmp loop_read 
 after_read:
 popa
 ret
 
 print_number:
 pusha
 mov eax, dword[sum]
 
 cmp dword[sum],0
 je print_zero

   extract_no:
    cmp dword[sum], 0
    je print_no
    inc byte[nod]
    mov edx, 0
    mov eax, dword[sum]
    mov ebx, 10
    div ebx
    push edx
    mov dword[sum], eax
    jmp extract_no

  print_no:
    cmp byte[nod], 0
    je after_print
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
after_print:
popa
ret

print_zero:
mov byte[temp],0
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp after_print

print_invalid:

loop_read1:
    mov eax, 3
    mov ebx, 0
    mov ecx, temp
    mov edx, 1
    int 80h
    
    cmp byte[temp], 10
    je after_read1
    
    mov eax, dword[number1]
    mov ebx, 10
    mul ebx
    movzx ebx, byte[temp]
    sub ebx, 30h
    add eax, ebx
    mov dword[number1], eax
    jmp loop_read1

after_read1:

mov eax,4
mov ebx,1
mov ecx,msg4
mov edx,len4
int 80h

mov eax,1
mov ebx,0
int 80h
