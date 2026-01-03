; Everything that comes after a semicolon (;) is a comment

; Define the constants 'RED', 'GREEN' and 'BLUE'
; They must be accessible from other source files
global RED
global GREEN
global BLUE
; Define the variable 'base_color' with the default value of 0xFFFFFF00
; It must be accessible from other source files
global base_color
section .rodata
    RED:   dd 0xFF000000
    GREEN: dd 0x00FF0000
    BLUE:  dd 0x0000FF00

section .data
    base_color: dd 0xFFFFFF00

section .text

    extern combining_function
; You should implement functions in the .text section

; the global directive makes a function visible to the test files
global get_color_value
get_color_value:
    mov eax, dword [rdi]
    ret

global add_base_color
add_base_color:
    mov eax, dword [rdi]
    mov dword [rel base_color], eax
    ret

global make_color_combination
make_color_combination:
    ; Store original parameter rdi (pointer to result) in rbx
    mov rbx, rdi

    ; Load value of base_color into the 32-bit register of rdi (edi)
    mov edi, dword [rel base_color]

    ; Load value pointed to by rsi into the 32-bit register of rsi (esi)
    mov esi, dword [rsi]

    call combining_function

    ; Get the 32-bit result from rax (eax) and store it at the address in rbx
    mov dword [rbx], eax
    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
