        .intel_syntax noprefix
        .text
input:
        push    rbp                             # Пролог функции.
        mov     rbp, rsp
        sub     rsp, 32
        
        push    r13
        push    r14
        
        mov     r13, rdi                        # Первый формальный параметр функции input (char *str).
        mov     r14, 0                          # Счетчик (int i = 0).
.L3:
        mov     rdi, QWORD PTR stdin[rip]
        call    fgetc@PLT                       # Осуществление посимвольного ввода.
        mov     [r13], al                       # Присвоение введенного символа текущему элементу строки. 
        
	add     r13, 1                          # Переход к следующему элементу.
        add     r14, 1                          # К счетчику прибавили 1.
        
	cmp     al, -1                          # Сравниваем введенный символ с символом конца ввода.
        je      .L2                             # Если это символ конца ввода - выходим из цикла.
        cmp     r14, 50000
        jl      .L3                             # Если счетчик меньше 50000, то еще можем вводить символы (возращаемся в цикл).
.L2:
        mov     al, 0
        sub     r13, 1
        mov     [r13], al                       # Эта и две строки выше показывают, что последнему элементу присваивается нулевой символ.
        nop
        
        pop     r14
        pop     r13
        
        add     rsp, 32                         # Эпилог функции.
        mov     rsp, rbp
        pop     rbp
        ret
changeString:
        push    rbp                             # Пролог фунции.
        mov     rbp, rsp
        sub     rsp, 32
        
        push    rbx
        push    r12
        push    r13
        
        mov     rbx, rdi                        # Первый формальный параметр функции changeString.
        mov     rdi, rbx
        call    strlen@PLT
        mov     r12, rax                        # В r12 храним фактический размер строки.
        mov     r13, 0                          # Счетчик (int i = 0).
        jmp     .L5                             # Переход к .L5.
.L8:
        mov     al, [rbx]                       # В al помещаем текущий символ.
        cmp     al, 90                          # Сравниваем с кодом 90.
        jg      .L6                             # Если больше 90, то переходим к .L6.
        cmp     al, 64                          # Сравниваем с кодом 64.
        jle     .L6                             # Если меньше или равен - переход к .L6.
        add     al, 32                          # Сделали букву заглавной
        mov     [rbx], al                       # Присвоили текущему элементу.
        jmp     .L7                             # Переход к .L7.
.L6:
        cmp     al, 122                         # Сравниваем с кодом 122.
        jg      .L7                             # Если код больше 122, переходим к .L7.
        cmp     al, 96
        jle     .L7                             # Если код меньше или равен 96, то переходим к .L7.
        sub     al, 32
        mov     [rbx], al                       # Присвоили элементу строчную букву.
.L7:
        add     r13, 1                          # ++i.
        add     rbx, 1                          # Переход к следующему элементу.
.L5:
        cmp     r13, r12                        # Проверка на завершение цикла.
        jl      .L8                             # Если счетчик меньше размера строки, то еще раз итерируемся.
        nop
        nop
        
        pop     r13
        pop     r12
        pop     rbx
        
        add     rsp, 32                         # Эпилог функции.
        mov     rsp, rbp
        pop     rbp
        ret
        .section        .rodata
.LC0:
        .string "\nFinal string: %s"
        .text
        .globl  main
main:
        push    rbp                             # Пролог функции.
        mov     rbp, rsp
        sub     rsp, 40
        push    rbx
        
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
        
        lea     rbx, -50016[rbp]                # Аналогично char buffer[50000] в программе на Си (храним в rbx).
        
        mov     rdi, rbx                        # Первый фактический параметр функции input (char buffer[50000]).
        call    input                           # Вызов функции для ввода строки.
        
        mov     rdi, rbx                        # Первый фактический параметр функции changeString (char buffer[50000]).
        call    changeString                    # Вызов функции для изменения строки.

        mov     rsi, rbx                        # Второй фактический параметр функции printf (char buffer[50000]).
        lea     rdi, .LC0[rip]                  # Первый фактический параметр функции printf ("\nFinal string: %s").
        mov     eax, 0
        call    printf@PLT                      # Вывод полученной строки на экран.
        mov     eax, 0                          # Завершение программы с нулевом кодом возврата.
        mov     rdx, QWORD PTR -8[rbp]
        sub     rdx, QWORD PTR fs:40
        je      .L11
        call    __stack_chk_fail@PLT
.L11:
        pop     rbx
        
        add rsp, 40                             # Эпилог функции.
        mov rsp, rbp
        pop rbp
        ret