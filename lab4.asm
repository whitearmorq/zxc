%include 'additional_functions.asm'          
section .data

lab4 db 'lab4.txt', 0h                              
a  dd 17H, 25H, 21H, 3H, 28H, 42H                   
t1_msg db 'My array is: ',                        
t1_len equ $ - t1_msg,
t2_msg db 0xa, 'This is my file now lol',                    
t2_len equ $ - t2_msg,

section .bss                                        
file_data resb 255,                                 
sum resb 10,
string_ascii resb 10,

section .text
global _start                                    

 input:                                                    
    mov    edx, 0                                  
    div    ecx                                     
    push   edx                               
    inc    ebx                                      
    cmp    eax, 0
    jne    input
    mov    ecx, ebx                             
    mov    ebx, 0

reverse:                          
    pop    edx                                   
    add    edx, 48                                 
    mov    [string_ascii + ebx], edx                   
    inc    ebx                              
    dec    ecx                                      
    cmp    ecx, 0
    JNE    reverse
    ret

_start:
    mov    ecx, t1_msg            
    mov    edx, t1_len             
    mov    ebx, 1               
    mov    eax, 4                   
    int    80h

    mov    eax, [a]                                 
    add    eax, [a + 4]                       
    add    eax, [a + 8]
    add    eax, [a + 12]
    add    eax, [a + 16]  
    add    eax, [a + 20]
    call   print_number ;                         
    mov    [sum], eax

    mov    eax, [sum]
    mov    ecx, 10                 
    mov    ebx, 0                                   
    call   input;                         
    mov    ebx, lab4                
    mov    eax, 8 ;                              
    mov    ecx, 01111111111b                  
    int    80h
 



    mov    ebx, eax                              
    mov    ecx, t1_msg 
    mov    edx, t1_len
    mov    eax, 4 ;                                
    int    80h

    mov    edx, 3
    mov    ecx, string_ascii
    mov    eax, 4 ;                             
    int    80h

    mov    ecx, 0                 
    mov    ebx, lab4                          
    mov    eax, 5 ;                           
    int    80h

    mov    ebx, eax                                
    mov    edx, t1_len + 3 ;        
    mov    ecx, file_data                          
    mov    eax, 3 ; sys_read                        
    int    80h 

    mov    edx, t1_len + 3 ; 
    mov    ecx, file_data                        
    mov    ebx, 1
    mov    eax, 4 ;                          
    int    80h 

    mov   eax, 6 ;                          
    int   80h

    mov    ecx, 1                                  
    mov    ebx, lab4
    mov    eax, 5 ;                          
    int    80h 

    mov    ebx, eax                            
    mov    ecx, 0 ;                              
    mov    edx, 2                              
    mov    eax, 19 ;                          
    int    80h

    mov    ecx, t2_msg                             
    mov    edx, t2_len                  
    mov    eax, 4  ;                                
    int    80h

    call   quit