; Everything that comes after a semicolon (;) is a comment

C2 equ 2
C3 equ 3
C4 equ 4
C5 equ 5
C6 equ 6
C7 equ 7
C8 equ 8
C9 equ 9
C10 equ 10
CJ equ 11
CQ equ 12
CK equ 13
CA equ 14

TRUE equ 1
FALSE equ 0

section .text

; You should implement functions in the .text section

; the global directive makes a function visible to the test files
global value_of_card
value_of_card:
    ; This function takes as parameter a number representing a card
    ; The function should return the numerical value of the passed-in card

    ;rdi = card number

    cmp rdi, C10
    jle .number ; if(rdi <= C10) goto: .number
    
    cmp rdi, CA
    jz .ca ; if(rdi == CA) goto: .ca

    jmp .face ;else goto: .face


    .ca: ; Ace
        mov rax, 1
        jmp .end

    .number: ; Non-face cards
        mov rax, rdi
        jmp .end

    .face: ;face cards
        mov rax, 10
        jmp .end

    .end:
        ret

global higher_card
higher_card:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return which card has the higher value
    ; If both have the same value, both should be returned
    ; If one is higher, the second one should be 0

    mov r8, rdi ;card one
    mov r9, rsi ;card two

    call value_of_card
    mov r10, rax
    mov rdi, rsi
    call value_of_card
    mov r11, rax
    cmp r10, r11
    je .e
    ja .card_one
    jb .card_two

    .card_one:
        mov rax, r8
        mov rdx, 0
        jmp .end
    
    .card_two:
        mov rax, r9
        mov rdx, 0
        jmp .end


    .e:
        mov rax, r8
        mov rdx, r9
        jmp .end

    .end:
        ret

global value_of_ace
value_of_ace:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return the value of an upcoming ace

    cmp rdi, CA
    je .g ;if(rdi = CA) goto: .g

    cmp rsi, CA
    je .g ;if(rsi = CA) goto: .g

    call value_of_card
    mov r10, rax ;value of card one
    mov rdi, rsi
    call value_of_card
    mov r11, rax ;value of card two

    add rax, r10 ;value of both cards

    add rax, 11 ;value of both cards + high ace

    cmp rax, 21 ;compare total to blackjack
    jle .le ;if(rax <= 21) goto: .le
    jmp .g ;else goto: .g
    
    .le:
        mov rax, 11
        jmp .end
    .g:
        mov rax, 1
        jmp .end

    .end:
        ret

global is_blackjack
is_blackjack:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards form a blackjack, and FALSE otherwise

    cmp rdi, CA
    je .cardOneAce

    cmp rsi, CA
    je .cardTwoAce

    jmp .false

    .cardOneAce:
        mov rdi, rsi
        call value_of_card
        cmp rax, 10
        je .true
        jne .false

    .cardTwoAce:
        call value_of_card
        cmp rax, 10
        je .true
        jne .false

    .true:
        mov rax, TRUE
        jmp .end
    .false:
        mov rax, FALSE
        jmp .end

    .end:
        ret

global can_split_pairs
can_split_pairs:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards can be split into two pairs, and FALSE otherwise

    call value_of_card
    mov r9, rax
    mov rdi, rsi
    call value_of_card
    cmp rax, r9
    je .true
    jmp .false

    .true:
        mov rax, TRUE
        jmp .end
    .false:
        mov rax, FALSE
        jmp .end
    .end:
        ret

global can_double_down
can_double_down:
    ; This function takes as parameters two numbers each representing a card
    ; The function should return TRUE if the two cards form a hand that can be doubled down, and FALSE otherwise

    call value_of_card
    mov r9, rax
    mov rdi, rsi
    call value_of_card
    add rax, r9
    cmp rax, 11
    jle .lessThan11
    jmp .false

    .lessThan11:
        cmp rax, 9
        jge .true
        jmp .false

    .true:
        mov rax, TRUE
        jmp .end
    .false:
        mov rax, FALSE
        jmp .end

    .end:
        ret

%ifidn __OUTPUT_FORMAT__,elf64
section .note.GNU-stack noalloc noexec nowrite progbits
%endif
