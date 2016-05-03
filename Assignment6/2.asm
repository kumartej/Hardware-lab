section .data:
msg1: db "Enter radius",0Ah
len1: equ $-msg1
msg2: db "perimeter: ",0Ah
len2: equ $-msg2
fmt1: db "%lf",0
fmt2: db "%lf",10

section .bss
num: resd 1
num1: resd 1
num2: resd 1
num3: resd 1

section .text
global main
extern scanf
extern printf

main:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,len1
int 80h

call readnum

mov dword[num1],44
fimul dword[num1]
mov dword[num1],7
fidiv dword[num1]

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,len2
int 80h

call printnum
jmp exit

exit:
mov eax,1
mov ebx,0
int 80h

readnum:
push ebp
mov ebp,esp
sub esp,8

lea eax,[esp]
push eax
push fmt1
call scanf

fld qword[ebp-8]
mov esp,ebp
pop ebp
ret

printnum:
push ebp

mov ebp,esp
sub esp,8
fst qword[ebp-8]
push fmt2
call printf
mov esp,ebp

pop ebp
ret
