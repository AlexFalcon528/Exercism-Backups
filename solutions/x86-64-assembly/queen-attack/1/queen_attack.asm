section .text

BOARD_SIZE equ 8

global can_create
can_create:
    ; Provide your implementation here
    ; The function has type signature int can_create(int row, int column)
    ; Both arguments and the return value are of int type, which is a 32-bit signed integer
    ; The return value should be set to zero if false and non-zero if true
    
    ;edi, esi

    cmp edi, BOARD_SIZE
    jge .false

    cmp esi, BOARD_SIZE
    jge .false

    cmp edi, 0
    jl .false

    cmp esi, 0
    jl .false
    
    
    mov rax, 1
    jmp .end
    
    .false:
        mov rax, 0
        jmp .end
    .end:
        ret

global can_attack
can_attack:
    ; Provide your implementation here
    ; The function has type signature int can_attack(int white_row, int white_column, int black_row, int black_column)
    ; All arguments and the return value are of int type, which is a 32-bit signed integer
    ; The return value should be set to zero if false and non-zero if true

    ;edi, esi, edx, ecx

    ;horizontal
    cmp edi, edx
    je .true

    ;vertical
    cmp esi, ecx
    je .true

    ;diagonal
    sub edx, edi
    sub esi, ecx
    
    mov r9d, edx
    neg r9d
    cmovl r9d, edx

    mov r10d, esi
    neg r10d
    cmovl r10d, esi
    
    cmp r9d, r10d
    je .true
    jmp .false

    .true:
        mov rax, 1
        jmp .end
    .false:
        mov rax, 0
        jmp .end
    .end:
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
