SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

section .data
    firstOption db "Press : 1 to Add,", 0xa
    lenfirstOption equ $ - firstOption
    secondOption db "Press : 2 to Subtract,", 0xa
    lensecondOption equ $ - secondOption
    option3 db "Press : 3 to Multiply,", 0xa
    lenOption3 equ $ - option3
    option4 db "Press : 4 for DIVISION: "
    lenOption4 equ $ - option4
    option5 db "Press : a number between 1 and 4!", 0xa
    lenOption5 equ $ - option5
    firstNum db "Press : your first number: "
    fNumLen equ $ - firstNum
    secondNum db "Press : your second number: "
    sNumLen equ $ - secondNum


section .bss
    fNum resb 1
    sNum resb 1
    selectedOption resb 1
    result resb 1

section .text
    global _start
_start:
    call _printEnterFirstNumber
    call _enterFirstNumber
    call _printEnterSecondNumber
    call _enterSecondNumber
    call _printfirstOption
    call _printsecondOption
    call _printOption3
    call _printOption4
    call _getOption
    call if
    call exit

exit:    
   mov rax, SYS_EXIT   
   int 0x80

_printEnterFirstNumber:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, firstNum
    mov rdx, fNumLen
    syscall
    ret

_enterFirstNumber:
    mov rax, STDIN
    mov rdi, 0
    mov rsi, fNum
    mov rdi, 1
    syscall
    ret

_printEnterSecondNumber:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, secondNum
    mov rdx, sNumLen
    syscall
    ret



_enterSecondNumber:
    mov rax, STDIN
    mov rdi, 0
    mov rsi, sNum
    mov rdi, 1
    syscall
    ret


_printfirstOption:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, firstOption
    mov rdx, lenfirstOption
    syscall
    ret

_printsecondOption:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, secondOption
    mov rdx, lensecondOption
    syscall
    ret

_printOption3:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, option3
    mov rdx, lenOption3
    syscall
    ret

_printOption4:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, option4
    mov rdx, lenOption4
    syscall
    ret

_printError:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, option5
    mov rdx, lenOption5
    syscall
    ret

_getOption:
    mov rax, STDIN
    mov rdi, 0
    mov rsi, selectedOption
    mov rdi, 1
    syscall
    ret

if:
    mov al,[selectedOption]
    sub al,'0'
    cmp al, 1
    jne elseif1
    call _addition
    ret

elseif1:
    cmp al, 2
    jne elseif2
    call _subtraction
    ret

elseif2:
    cmp al, 3
    jne elseif3
    call _multipication
    ret


elseif3:
    cmp al, 4
    jne else
    call _division
    ret


else:
    call _printError
    ret


_move:
    mov rax, [fNum] 
    sub rax, '0'
    mov rbx, [sNum]
    sub rbx, '0'
    ret

_addition:
    call _move
    add rax, rbx
    add rax, '0'
    call _result
    ret

_subtraction:
    call _move
    sub rax, rbx
    add rax, '0'
    call _result
    ret


_assignInputs:
    mov al, [fNum]
    sub al, '0'
    mov bl, [sNum]
    sub bl, '0'
    ret

_multipication:
    call _assignInputs
    mul bl
    add al, '0'
    mov [result],al
    mov rax, SYS_WRITE        
    mov rbx, STDOUT
    mov rcx, result         
    mov rdx, 1        
    int 0x80
    ret

    
_division:
    call _assignInputs
    div bl
    add al, '0'
    mov [result], al
    mov rax, SYS_WRITE        
    mov rbx, STDOUT
    mov rcx, result         
    mov rdx, 1        
    int 0x80
    ret

_result:
    mov [result], rax
    mov rax, SYS_WRITE        
    mov rbx, STDOUT
    mov rcx, result         
    mov rdx, 1        
    int 0x80
    ret



