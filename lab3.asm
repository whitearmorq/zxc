%include 'additional_functions.asm'

global Start

section .data

a1 dd 17H
a2 dd 25H
b1 dd 21H
b2 dd 3H
c1 dd 28H
c2 dd 42H

section .text

Start:
mov    eax, [a1]
and    eax, [c2] ; a1&c2
xor    eax, [c2] ; (a1&c2),c2
mov    edx, eax
mov    eax, [a1] 
sub    eax, [a2] ; a1-a2
mov    ebx, [b1]
imul   ebx, [b2] ; b1*b2
mov    ecx, [c2] 
sub    ecx, [c1] ; c2-c1    
label1:        ; початок циклу
cmp    ecx,5
jnb    end
test   ecx,1
jnz    label2
sub    eax, ebx 
jmp    label3
label2:
add    eax, ecx
label3:
sub    ecx, 3H
jmp    label1
end: 
call quit