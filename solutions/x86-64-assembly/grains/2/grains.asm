section .text

TOTAL_SQUARES equ 64

global square
square:
    ; Provide your implementation here
    ; The function has type signature uint64_t square(int64_t number)
    ; The return value is of type uint64_t, which is an unsigned 64-bit integer
    ; The argument is of type int64_t, which is a signed 64-bit integer

    mov rax, 0

    cmp rdi, 0
    jle .end

    mov rax, 1 ;current grains
    mov r9, 1 ;current square

    .loop:
        cmp r9, rdi
        jge .end

        shl rax, 1
        inc r9

        jmp .loop
    
    .end:
        ret
square_mul:
    ; Provide your implementation here
    ; The function has type signature uint64_t square(int64_t number)
    ; The return value is of type uint64_t, which is an unsigned 64-bit integer
    ; The argument is of type int64_t, which is a signed 64-bit integer

    mov rax, 0

    cmp rdi, 0
    jle .end

    mov rax, 1 ;current grains
    mov r9, 1 ;current square
    mov r11, 2 ;the number 2

    .loop:
        cmp r9, rdi
        jge .end

        mul r11
        inc r9

        jmp .loop
    
    .end:
        ret


global total
total:
    ; Provide your implementation here
    ; The function has type signature uint64_t total(void)
    ; The return value is of type uint64_t, which is an unsigned 64-bit integer
    ; It has no argument

    mov rax, 1 ; current grains
    mov r9, 1 ; current square
    mov r10, 1 ; total grains

    .loop:
        cmp r9, TOTAL_SQUARES
        jge .end

        shl rax, 1
        add r10, rax
        inc r9

        jmp .loop
    
    .end:
        mov rax, r10
        ret

total_mul:
    ; Provide your implementation here
    ; The function has type signature uint64_t total(void)
    ; The return value is of type uint64_t, which is an unsigned 64-bit integer
    ; It has no argument

    mov rax, 1 ; current grains
    mov r9, 1 ; current square
    mov r10, 1 ; total grains
    mov r11, 2 ; the number 2

    .loop:
        cmp r9, TOTAL_SQUARES
        jge .end

        mul r11
        add r10, rax
        inc r9

        jmp .loop
    
    .end:
        mov rax, r10
        ret
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
