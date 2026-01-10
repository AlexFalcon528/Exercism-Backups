section .text
global leap_year
leap_year:
    ; Provide your implementation here
    ; The function has type signature int leap_year(int year)
    ; The return value and the argument are of type int, which is a 32-bit signed integer

    mov r9d, 4

    mov eax, edi
    cdq
    div r9d
    cmp edx, 0
    je .divisibleByFour
    jmp .false

    .divisibleByFour:
        mov r9d, 100
        mov eax, edi
        cdq
        div r9d
        cmp edx, 0
        je .divisibleByHundred
        jmp .true

    .divisibleByHundred:
        mov r9d, 400
        mov eax, edi
        cdq
        div r9d
        cmp edx, 0
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
