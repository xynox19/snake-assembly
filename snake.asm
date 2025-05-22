; snake.asm - Simple snake game for Windows console (NASM, win32)

%include "win32n.inc"

section .data
snake_char db 'O'
food_char  db '*'
blank_char db ' '

snake_x dd 10
snake_y dd 10

food_x dd 20
food_y dd 10

dir_x dd 1
dir_y dd 0

hOutput dd 0
coord COORD

msg db 'Game Over!', 0

section .text
global _start

_start:
    ; Get handle to console
    push -11
    call [GetStdHandle]
    mov [hOutput], eax

main_loop:
    call handle_input
    call move_snake
    call draw
    call Sleep_short

    jmp main_loop

handle_input:
    ; Up arrow
    push 0x26
    call [GetAsyncKeyState]
    test eax, eax
    jz .check_down
    mov dword [dir_x], 0
    mov dword [dir_y], -1

.check_down:
    push 0x28
    call [GetAsyncKeyState]
    test eax, eax
    jz .check_left
    mov dword [dir_x], 0
    mov dword [dir_y], 1

.check_left:
    push 0x25
    call [GetAsyncKeyState]
    test eax, eax
    jz .check_right
    mov dword [dir_x], -1
    mov dword [dir_y], 0

.check_right:
    push 0x27
    call [GetAsyncKeyState]
    test eax, eax
    jz .done_input
    mov dword [dir_x], 1
    mov dword [dir_y], 0

.done_input:
    ret

move_snake:
    ; Clear old position
    mov eax, [snake_x]
    mov [coord.X], eax
    mov eax, [snake_y]
    mov [coord.Y], eax
    push 1
    push blank_char
    lea eax, [coord]
    push eax
    mov eax, [hOutput]
    push eax
    call [WriteConsoleOutputCharacterA]

    ; Update position
    mov eax, [snake_x]
    add eax, [dir_x]
    mov [snake_x], eax
    mov eax, [snake_y]
    add eax, [dir_y]
    mov [snake_y], eax
    ret

draw:
    ; Draw snake
    mov eax, [snake_x]
    mov [coord.X], eax
    mov eax, [snake_y]
    mov [coord.Y], eax
    push 1
    push snake_char
    lea eax, [coord]
    push eax
    mov eax, [hOutput]
    push eax
    call [WriteConsoleOutputCharacterA]
    ret

Sleep_short:
    push 100
    call [Sleep]
    ret

; External functions
section .idata import data readable
library kernel32, "kernel32.dll", \
        user32,   "user32.dll"

import kernel32,\
       GetStdHandle,      "GetStdHandle",\
       WriteConsoleOutputCharacterA, "WriteConsoleOutputCharacterA",\
       SetConsoleCursorPosition, "SetConsoleCursorPosition",\
       Sleep, "Sleep"

import user32,\
       GetAsyncKeyState, "GetAsyncKeyState"
