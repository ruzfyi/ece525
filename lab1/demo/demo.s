        .section ".text"

// add function
        .global add
        .type   add, "function"
        .p2align 4
add:
        add w0, w0, w1
        ret

// subtract function
        .global sub
        .type   sub, "function"
sub:
        sub w0, w0, w1
        ret

// multiply function
        .global mul
        .type   mul, "function"
mul:
        mul w0, w0, w1
        ret

// divide function
        .global div
        .type   div, "function"
div:
        sdiv w0, w0, w1
        ret
