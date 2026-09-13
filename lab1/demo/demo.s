        .section ".text"

// add function
        .global add
        .type   add, "function"
        .p2align 4
add:
        add x0, x0, x1
        mov pc, lr

// subtract function
        .global sub
        .type   sub, "function"
sub:
        sub x0, x0, x1
        mov pc, lr

// multiply function
        .global mul
        .type   mul, "function"
mul:
        ret

// divide function
        .global div
        .type   div, "function"
div:
        ret
