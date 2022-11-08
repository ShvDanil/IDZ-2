        .file   "main.c"
        .intel_syntax noprefix
        .text
        .globl  input
        .type   input, @function
input:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     QWORD PTR -24[rbp], rdi
        mov     DWORD PTR -8[rbp], 0
.L3:
        mov     rax, QWORD PTR stdin[rip]
        mov     rdi, rax
        call    fgetc@PLT
        mov     DWORD PTR -4[rbp], eax
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        mov     edx, DWORD PTR -4[rbp]
        mov     BYTE PTR [rax], dl
        add     DWORD PTR -8[rbp], 1
        cmp     DWORD PTR -4[rbp], -1
        je      .L2
        cmp     DWORD PTR -8[rbp], 49999
        jle     .L3
.L2:
        mov     eax, DWORD PTR -8[rbp]
        cdqe
        lea     rdx, -1[rax]
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        mov     BYTE PTR [rax], 0
        nop
        leave
        ret
        .size   input, .-input
        .globl  changeString
        .type   changeString, @function
changeString:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     QWORD PTR -24[rbp], rdi
        mov     rax, QWORD PTR -24[rbp]
        mov     rdi, rax
        call    strlen@PLT
        mov     DWORD PTR -4[rbp], eax
        mov     DWORD PTR -8[rbp], 0
        jmp     .L5
.L8:
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 90
        jg      .L6
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 64
        jle     .L6
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        lea     ecx, 32[rax]
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        mov     edx, ecx
        mov     BYTE PTR [rax], dl
        jmp     .L7
.L6:
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 122
        jg      .L7
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        cmp     al, 96
        jle     .L7
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        movzx   eax, BYTE PTR [rax]
        lea     ecx, -32[rax]
        mov     eax, DWORD PTR -8[rbp]
        movsx   rdx, eax
        mov     rax, QWORD PTR -24[rbp]
        add     rax, rdx
        mov     edx, ecx
        mov     BYTE PTR [rax], dl
.L7:
        add     DWORD PTR -8[rbp], 1
.L5:
        mov     eax, DWORD PTR -8[rbp]
        cmp     eax, DWORD PTR -4[rbp]
        jl      .L8
        nop
        nop
        leave
        ret
        .size   changeString, .-changeString
        .section        .rodata
.LC0:
        .string "\nFinal string: %s"
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp
        mov     rbp, rsp
        lea     r11, -49152[rsp]
.LPSRL0:
        sub     rsp, 4096
        or      DWORD PTR [rsp], 0
        cmp     rsp, r11
        jne     .LPSRL0
        sub     rsp, 864
        mov     rax, QWORD PTR fs:40
        mov     QWORD PTR -8[rbp], rax
        xor     eax, eax
        lea     rax, -50016[rbp]
        mov     rdi, rax
        call    input
        lea     rax, -50016[rbp]
        mov     rdi, rax
        call    changeString
        lea     rax, -50016[rbp]
        mov     rsi, rax
        lea     rax, .LC0[rip]
        mov     rdi, rax
        mov     eax, 0
        call    printf@PLT
        mov     eax, 0
        mov     rdx, QWORD PTR -8[rbp]
        sub     rdx, QWORD PTR fs:40
        je      .L11
        call    __stack_chk_fail@PLT
.L11:
        leave
        ret
        .size   main, .-main
        .ident  "GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
        .section        .note.GNU-stack,"",@progbits
