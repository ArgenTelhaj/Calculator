SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

section .data
    option1 db "Enter 1 for ADDITION,", 0xa
    lenOption1 equ $ - option1
    option2 db "Enter 2 for SUBTRACTION,", 0xa
    lenOption2 equ $ - option2
    option3 db "Enter 3 for MULTIPLICATION,", 0xa
    lenOption3 equ $ - option3
    option4 db "Enter 4 for DIVISION: "
    lenOption4 equ $ - option4
    option5 db "Enter a number between 1 and 4!", 0xa
    lenOption5 equ $ - option5
    fNumMessage db "Enter your first number: "
    lenNum1 equ $ - fNumMessage
    sNumMessage db "Enter your second number: "
    lenNum2 equ $ - sNumMessage


section .bss
    firstNumber resb 1
    secondNumber resb 1
    selectedOption resb 1
    result resb 1

section .text
    global _start
_start:
    call _printEnterFirstNumber
    call _enterFirstNumber
    call _printEnterSecondNumber
    call _enterSecondNumber
    call _printOption1
    call _printOption2
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
    mov rsi, fNumMessage
    mov rdx, lenNum1
    syscall
    ret

_enterFirstNumber:
    mov rax, STDIN
    mov rdi, 0
    mov rsi, firstNumber
    mov rdi, 1
    syscall
    ret

_printEnterSecondNumber:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, sNumMessage
    mov rdx, lenNum2
    syscall
    ret



_enterSecondNumber:
    mov rax, STDIN
    mov rdi, 0
    mov rsi, secondNumber
    mov rdi, 1
    syscall
    ret


_printOption1:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, option1
    mov rdx, lenOption1
    syscall
    ret

_printOption2:
    mov rax, SYS_EXIT
    mov rdi, 1
    mov rsi, option2
    mov rdx, lenOption2
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
    mov rax, [firstNumber] 
    sub rax, '0'
    mov rbx, [secondNumber]
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
    mov al, [firstNumber]
    sub al, '0'
    mov bl, [secondNumber]
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



