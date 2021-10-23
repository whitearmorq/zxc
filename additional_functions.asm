iprint:
    push    eax             ; кидаем еах в стек
    push    ecx             ; кидаем есх в стек
    push    edx             ; кидаем edx в стек
    push    esi             ; кидаем esi в стек
    mov     ecx, 0          ; счетчик байтов, которые мы должны вывести в конце
 
divideLoop:
    inc     ecx             ; count each byte to print - number of characters
    mov     edx, 0          ; очистка edx
    mov     esi, 10         ; перемещаем 10 в esi
    idiv    esi             ; делим еах на esi
    add     edx, 48         ; по сути - получение символа ASCII
    push    edx             ; кидаем символ в стек
    cmp     eax, 0          ; проверка можем ли дальше делить
    jnz     divideLoop      ; елси не ноль - в начало
 
printLoop:
    dec     ecx             ; считаем байты, которые отправляем в стек
    mov     eax, esp        ; перемещаем стэк поинтер в еах
    call    print          ;  вызов функции вывода строки
    pop     eax            
    cmp     ecx, 0          ; проверка вывели ли все байты со стека
    jnz     printLoop        
 
    pop     esi             
    pop     edx             
    pop     ecx             
    pop     eax             
    ret
    
print_number:
    call    iprint          ; вызов основной функции вывода
    push    eax             
    mov     eax, 0Ah        ; лайнфид
    push    eax             ; кидаем лайнфид в стек
    mov     eax, esp        ; стэк поинтер - в еах
    call    print           ; вызов функции вывода
    pop     eax             
    pop     eax             
    ret
 
slen:
    push ebx
    mov ebx,eax

nextchar:
    cmp byte [eax], 0
    jz  finished
    inc eax
    jmp nextchar

finished:
    sub eax,ebx
    pop ebx
    ret

print:
    push edx
    push ecx
    push ebx
    push eax
    call slen
    mov  edx,eax
    pop  eax
    mov  ecx,eax
    mov  ebx,1
    mov  eax,4
    int  80h
    pop ebx
    pop ecx
    pop edx
    ret

print_with_lifefeed:
    call print
    push eax
    mov  eax, 0Ah
    push eax
    mov  eax,esp
    call print
    pop  eax
    pop  eax
    ret

quit:
    mov ebx,0
    mov eax,1
    int 80h
    ret
