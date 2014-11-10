    AREA asm_func, CODE, READONLY
    EXPORT bubble_sort
bubble_sort
    PUSH {R3, R4, R5, R6, R7, R8, R9}   ;Save some registers
    MOV R3, #0                          ; Initialize R3 with 0
    
outer_loop

    MOV R4, #0                          ; Initialize R4 with 0
    
inner_loop

    ADD R6, R4, #1                      ; Store index+1 in R6
    ADD R6, R0, R6, LSL#2               ; Store memory address of array[index+1] in R6
    ADD R7, R0, R4, LSL#2               ; Store memory address of array[index] in R7
    
    LDR R10, [R7]                       ; Load array[index] into R10
    LDR R11, [R6]                       ; Load array[index+1] into R11
    CMP R2, #0                          ; If mode == 0, then ascending. Else, descending.
    BNE descending
    CMP R10, R11                        ; If array[index] <= array[index+1]
    BLE end_if                          ; Branch to end_if
    B   next                            ; Ascending -> skip descending condition
descending
    CMP R10, R11                        ; If array[index] >= array[index+1]
    BGE end_if                          ; Branch to end_if
next
        ; Else, continue                ; Swap 2 elements of array
    LDR R5, [R7]                        ; Load array[index] into R5
    LDR R8, [R6]                        ; Load array[index+1] into R8
    STR R8, [R7]                        ; Store array[index+1] into R7
    STR R5, [R6]                        ; Store array[index] into R5
    
end_if

    ADD R4, R4, #1                      ; R4++
    SUB R9, R1, R3
    SUB R9, R9, #1                      ; R9 = number of elements in the array - R3 - 1
    
    CMP R4, R9                          ; If R4 < R9
    BLT inner_loop                      ; Branch to inner_loop
        
    ADD R3, R3, #1                      ; R3++
    SUB R9, R1, #1                      ; R9 = number of elements in the array - 1
    
    CMP R3, R9                          ; If R3 < R9
    BLT outer_loop                      ; Branch to outer_loop
    
    POP {R3, R4, R5, R6, R7, R8, R9}    ;Restore registers

    BX      LR                          ; Branch and change instruction set
    END