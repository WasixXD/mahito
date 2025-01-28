bits 64
section .text
    extern socket, bind, listen, accept, perror
    global main

main:
    
    ; allocating sockaddr_in
    sub rsp, SIZE_OF_SERVER_ADDR

    ; ; sin_family
    mov word [rsp], AF_INET

    ; ; sin_port 
    mov word [rsp + 2], PORT

    ; ; s_addr
    mov dword [rsp + 4], INADDR_ANY

    ; ; unsigned char data[8]
    mov qword [rsp + 8], 0x0

    mov rdi, AF_INET
    mov rsi, SOCK_STREAM
    mov rdx, 0
    call socket

    cmp rax, 0
    jl exit_socket_error

    ; holding the socket_fd
    mov r12, rax
    
    mov rdi, r12
    mov rsi, rsp
    mov rdx, SIZE_OF_SERVER_ADDR
    call bind

    cmp rax, 0
    jl exit_bind_error

    mov rdi, r12
    mov rsi, 10
    call listen

    cmp rax, 0
    jl exit_error

    call listening_msg

while:
    mov rdi, r12 
    mov rsi, rsp
    mov rdx, 4
    call accept

    cmp rax, 0
    jl exit_error

    call client_connect

    jmp while



exit_good:
    mov rax, 60
    mov rdi, 0
    syscall


exit_socket_error:
    mov rax, 1
    mov rdi, 1    
    mov rsi, SOCKET_ERROR
    mov rdx, SOCKET_LEN
    syscall
    jmp exit_error

exit_bind_error:
    mov rax, 1
    mov rdi, 1    
    mov rsi, BIND_ERROR
    mov rdx, BIND_LEN
    syscall
    jmp exit_error

exit_error:
    mov rax, 60
    mov rdi, 1
    syscall

listening_msg:
    mov rax, 1
    mov rdi, 1    
    mov rsi, LISTENING
    mov rdx, LISTENING_LEN
    syscall
    ret

client_connect:
    mov rax, 1
    mov rdi, 1    
    mov rsi, CONNECT
    mov rdx, CONNECT_LEN
    syscall
    ret

section .data
    AF_INET equ 2
    SOCK_STREAM equ 1
    INADDR_ANY equ 0
    PORT equ 6000
    SIZE_OF_SERVER_ADDR equ 16

    BIND_ERROR db `[!] Error on bind() to socket\n`
    BIND_LEN equ $ - BIND_ERROR

    SOCKET_ERROR db `[!] Error on socket() to socket\n`
    SOCKET_LEN equ $ - SOCKET_ERROR

    LISTENING db `[*] Server listening at localhost:6000\n` 
    LISTENING_LEN equ $ - LISTENING

    CONNECT db `A client has connected\n`
    CONNECT_LEN equ $ - CONNECT