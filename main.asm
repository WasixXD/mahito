bits 64

SYS_SOCKET equ 41
AF_INET equ 2
SOCK_STREAM equ 1
PROTOCOL equ 0

SYS_BIND equ 49
SYS_LISTEN equ 50
BACKLOG equ 10

SYS_ACCEPT equ 43

SYS_READ equ 0

buffer: times 256 db 0


sockaddr:
    sin_family: dw 2
    sin_port: dw 0x901f
    s_addr: dd 0
    padding: dq 0
    sockaddr_len: equ $ - sockaddr

; sockaddr_in:
;     sin_family: dw 0
;     sin_port: dw 0
;     s_addr: dd 0
;     padding: dq 8
;     sockaddr_in_len: equ $ - sockaddr

section .text
    global main

main:
    mov rax, SYS_SOCKET
    mov rdi, AF_INET
    mov rsi, SOCK_STREAM
    mov rdx, PROTOCOL
    syscall
    cmp rax, 0
    jl exit_socket

    mov r12, rax

    mov rax, SYS_BIND
    mov rdi, r12
    mov rsi, sockaddr
    mov rdx, 16
    syscall

    cmp rax, 0
    jl exit_bind

    mov rax, SYS_LISTEN
    mov rdi, r12
    mov rsi, BACKLOG
    syscall
    
    cmp rax, 0
    jl exit_listen

while:
    mov rax, SYS_ACCEPT
    mov rdi, r12
    mov rsi, 0
    mov rdx, 0
    syscall


    mov r13, rax

    cmp rax, 0
    jl exit_accept

    mov rax, SYS_READ
    mov rdi, r13
    mov rsi, buffer
    mov rdx, 256
    syscall


    ; mov rax, 3
    ; mov rdi, r13
    ; syscall


    jmp while



exit:
    mov rax, 60
    mov rdi, 0
    syscall

    ret

exit_socket:
    mov rax, 60
    mov rdi, 1
    syscall

    ret

exit_bind:
    mov rax, 60
    mov rdi, 2
    syscall

    ret

exit_listen:
    mov rax, 60
    mov rdi, 3
    syscall

    ret

exit_accept:
    mov rax, 60
    mov rdi, 4
    syscall

    ret
