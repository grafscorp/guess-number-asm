;Подключение функций из С библиотеки 
extern _printf ;Output
extern _scanf ;Input
extern _srand ;Generate seed
extern _rand ;Randomize
extern _time ;Get time
extern _ExitProcess@4 ;Stop procces

section .data
    welcome db 'Welcome I guessed a number from 1 to 100.',0
    prompt db 'Enter number : ', 0
    count_attempts db 'U have attempts : ', 0
    win_msg db 'YOU ARE WIN!!!',0
    high_msg db 'The number is too high',0
    low_msg db 'The number is too low',0
    newline db 13, 10, 0 ;\n
    ;Input data, for scanf
    int_format db '%d', 0 

    number dd 0 ; Загадонное число
    guess dd 0 ; Число введенное пользователем
    attempts dd 0 ;Счётчик попыток

section .text
global _main

_main: 
    ; Set NULL for time (Get seed)
    push 0
    call _time
    add esp, 4
    push eax
    call _srand
    add esp, 4

    ;Generation
    call _rand
    xor edx, edx ;NULL edx 
    mov ecx, 100 
    div ecx ;devided by 100
    inc edx ; 0-99 to 1-100
    mov [number], edx 

    push welcome
    call _printf
    add esp,4

    push newline
    call _printf
    add esp,4 

game_loop:
    inc dword [attempts] ;attempts++

    ;Print attempts
    push count_attempts
    call _printf
    add esp, 4
    push dword [attempts]
    push  int_format
    call _printf
    add esp, 8
    push newline
    call _printf
    add esp,4
    ;Input field
    push prompt
    call _printf
    add esp, 4
    push guess
    push int_format
    call _scanf
    add esp, 8

    mov eax, [guess]
    cmp eax, [number] ;Compare [guess] and [number]

    je win
    jg too_high
    jl too_low
    
too_high:
    push high_msg
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 4

    jmp game_loop

too_low:
    push low_msg
    call _printf
    add esp,4

    push newline
    call _printf
    add esp, 4

    jmp game_loop

win:
    push win_msg
    call _printf
    add esp, 4
    push newline
    call _printf
    add esp, 4
    ;Return 0, Exit
    push 0
    call _ExitProcess@4

