; Everything that comes after a semicolon (;) is a comment

section .text
PKEY equ 0b1011_0011_0011_1100
; You should implement functions in the .text section
; A skeleton is provided for the first function

; the global directive makes a function visible to the test files
global extract_higher_bits
extract_higher_bits:
    ; This function has a 16-bit integer as argument.
    ; it returns the higher 8-bit value of the argument.
    mov ax, di
    shr ax, 8
    movsx rax, al
    ret

; TODO: define the 'extract_lower_bits' function.
; This function takes one 16-bit integer as argument and must return the lower 8-bit value of it.
global extract_lower_bits
extract_lower_bits:
    mov ax, di
    movsx rax, al
    ret
    
; TODO: define the 'extract_redundant_bits' function.
; This function takes one 16-bit integer as argument.
; It returns a 8-bit integer with all bits set in both the lower and the higher 8 bits of the argument.
global extract_redundant_bits
extract_redundant_bits:
   mov rax, rdi
   and al, ah
   movsx rax, al
   ret

; TODO: define the 'set_message_bits' function.
; This function takes one 16-bit integer as argument.
; It returns a 8-bit integer with all bits set if they are set in the higher 8 bits of the argument, the others unchanged.
global set_message_bits
set_message_bits:
    mov rax, rdi
    or al, ah
    ret
; TODO: define the 'rotate_private_key' function.
; This function takes one 16-bit integer as argument.
; It returns a 16-bit integer with bits of the private key rotated to the left a number of positions equal to the redundant bits.
; The private key is 0b1011_0011_0011_1100.
; A bit is redundant when it is set in both the lowest 8-bit portion of the argument and the highest 8-bit portion of the argument.
global rotate_private_key
rotate_private_key:
    call extract_redundant_bits
    xor ah, ah
    popcnt cx, ax
    mov ax, PKEY
    rol ax, cl
    
    ret
; TODO: define the 'format_private_key' function.
; This function takes one 16-bit integer as argument.
; It returns a 8-bit integer with the private key fully formatted.
; To format a private key, you must:
; - Rotate it.
; - Isolate the lowest 8-bit portion of the rotated private key, which is the base value.
; - Isolate the highest 8-bit portion of the rotated private key, which is a mask to be applied to the base value.
; - Flip set bits in the base value that are also set in the mask.
; - Flip all bits in the result.
global format_private_key
format_private_key:
    mov r9, rdi
    call rotate_private_key
    xor al, ah
    xor ah, ah
    not rax
    ret
; TODO: define the 'decrypt_message' function
; This function takes one 16-bit integer as argument
; It returns a 16-bit integer, of which:
; - The higher 8 bits are the formatted private key, according to 'format_private_key'
; - The lower 8 bits are the message with all bits set, according to 'set_message_bits'
global decrypt_message
decrypt_message:
    mov r9, rdi
    call format_private_key
    mov cl, al
    mov rdi, r9
    
    call set_message_bits
    mov ah, cl
    ret
%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif