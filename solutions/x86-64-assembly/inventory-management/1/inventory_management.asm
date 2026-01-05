; Everything that comes after a semicolon (;) is a comment

WEIGHT_OF_EMPTY_BOX equ 500
TRUCK_HEIGHT equ 300
PAY_PER_BOX equ 5
PAY_PER_TRUCK_TRIP equ 220

section .text

; You should implement functions in the .text section
; A skeleton is provided for the first function

; the global directive makes a function visible to the test files
global get_box_weight
get_box_weight:
    ; This function takes the following parameters:
    ; - The number of items for the first product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the first product, in grams, as a 16-bit non-negative integer
    ; - The number of items for the second product in the box, as a 16-bit non-negative integer
    ; - The weight of each item of the second product, in grams, as a 16-bit non-negative integer
    ; The function must return the total weight of a box, in grams, as a 32-bit non-negative integer

    ; rdi (di) = a
    ; rsi (si) = b
    ; rdx (dx) = c
    ; rcx (cx) = d
    
    ; a * b + c * d + WEIGHT_OF_EMPTY_BOX


    movzx r10d, dx                ; r10d = c

    movzx eax, di                   ; eax = a
    movzx r11d, si                   ; r11d = b
    mul r11d                         ; edx:eax = a * b (since a and b are 16 bit, edx can be thrown away)

    mov r11d, eax                    ; r11d = a * b

    mov eax, r10d                   ; eax = c
    movzx r10d, cx                  ; r10d = d
    mul r10d                         ; edx:eax = c * d (since c and d are 16 bit, edx can be thrown away)

    add eax, r11d                    ; rax = (a * b) + (c * d)
    add eax, WEIGHT_OF_EMPTY_BOX    ; rax = (a * b) + (c * d) + WEIGHT_OF_EMPTY_BOX

    ret

global max_number_of_boxes
max_number_of_boxes:
    ; TODO: define the 'max_number_of_boxes' function
    ; This function takes the following parameter:
    ; - The height of the box, in centimeters, as a 8-bit non-negative integer
    ; The function must return how many boxes can be stacked vertically, as a 8-bit non-negative integer

    ;di = a

    ; TRUCK_HEIGHT / a

    mov ax, TRUCK_HEIGHT ; rax = TRUCK_HEIGHT
    div dil

    ret

global items_to_be_moved
items_to_be_moved:
    ; TODO: define the 'items_to_be_moved' function
    ; This function takes the following parameters:
    ; - The number of items still unaccounted for a product, as a 32-bit non-negative integer
    ; - The number of items for the product in a box, as a 32-bit non-negative integer
    ; The function must return how many items remain to be moved, after counting those in the box, as a 32-bit integer

    ;edi = a
    ;esi = b

    movsx rax, edi
    sub eax, esi

    ret

global calculate_payment
calculate_payment:
    ; TODO: define the 'calculate_payment' function
    ; This function takes the following parameters:
    ; rdi - The upfront payment, as a 64-bit non-negative integer
    ; esi - The total number of boxes moved, as a 32-bit non-negative integer
    ; edx - The number of truck trips made, as a 32-bit non-negative integer
    ; ecx - The number of lost items, as a 32-bit non-negative integer
    ; r8 - The value of each lost item, as a 64-bit non-negative integer
    ; r9b - The number of other workers to split the payment/debt with you, as a 8-bit positive integer
    ; The function must return how much you should be paid, or pay, at the end, as a 64-bit integer (possibly negative)
    ; Remember that you get your share and also the remainder of the division


    ;return (((esi * PAY_PER_BOX) + (edx * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) / (r9b + 1)) + (((esi * PAY_PER_BOX) + (edx * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) % (r9b + 1))

    movzx r9, r9b ;r9 = r9b

    ;return (((esi * PAY_PER_BOX) + (edx * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) / (r9 + 1)) + (((esi * PAY_PER_BOX) + (edx * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) % (r9 + 1))

    inc r9 ; r9 = r9 + 1

    ;return (((esi * PAY_PER_BOX) + (edx * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) / (r9)) + (((esi * PAY_PER_BOX) + (edx * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) % (r9))

    mov eax, edx ; eax = edx

    ;return (((esi * PAY_PER_BOX) + (eax * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) / (r9)) + (((esi * PAY_PER_BOX) + (eax * PAY_PER_TRUCK_TRIP) - (ecx * r8) - rdi ) % (r9))

    imul rax, PAY_PER_TRUCK_TRIP ; rax = eax * PAY_PER_TRUCK_TRIP

    ;return (((esi * PAY_PER_BOX) + (rax) - (ecx * r8) - rdi ) / (r9)) + (((esi * PAY_PER_BOX) + (rax) - (ecx * r8) - rdi ) % (r9))

    mov r10, rax ;r10 = rax

    ;return (((esi * PAY_PER_BOX) + (r10) - (ecx * r8) - rdi ) / (r9)) + (((esi * PAY_PER_BOX) + (r10) - (ecx * r8) - rdi ) % (r9))

    mov eax, esi ; eax = esi

    ;return (((eax * PAY_PER_BOX) + (r10) - (ecx * r8) - rdi ) / (r9)) + (((eax * PAY_PER_BOX) + (r10) - (ecx * r8) - rdi ) % (r9))

    imul rax, PAY_PER_BOX ; rax = eax * PAY_PER_BOX

    ;return (((rax) + (r10) - (ecx * r8) - rdi ) / (r9)) + (((rax) + (r10) - (ecx * r8) - rdi ) % (r9))

    mov r11, rax ; r11 = rax

    ;return (((r11) + (r10) - (ecx * r8) - rdi ) / (r9)) (((r11) + (r10) - (ecx * r8) - rdi ) % (r9))

    mov eax, ecx ;eax = ecx

    ;return (((r11) + (r10) - (eax * r8) - rdi ) / (r9)) + (((r11) + (r10) - (eax * r8) - rdi ) % (r9))

    imul rax, r8 ;rax = eax * r8

    ;return (((r11) + (r10) - (rax) - rdi ) / (r9)) + (((r11) + (r10) - (rax) - rdi ) % (r9))

    add r11, r10 ;r11 = r11 + r10

    ;return (((r11) - (rax) - rdi ) / (r9)) + (((r11) + (r10) - (rax) - rdi ) % (r9))

    sub r11, rax ;r11 = r11 - rax

    ;return (((r11) - rdi ) / (r9)) + (((r11) + (r10) - (rax) - rdi ) % (r9))

    sub r11, rdi ;r11 = r11 - rdi

    ;return (r11 / r9) + (r11 % r9)

    mov rax, r11 ;rax = r11

    ;return (rax / r9) + (rax % r9)

    cqo

    idiv r9

    ;return rax + rdx

    add rax, rdx ;rax = rax + rdx

    ;return rax

    ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
