.model small
.stack 100h
.data    
    endl db 13, 10, '$';
.code
    mov ax, @data
    mov ds, ax   
    mov cx, 0
    lap: mov ah, 01h
        int 21h
        mov ah, 0
        cmp al, '$'
        je print
        push ax 
        inc cx
        jmp lap
    print: 
        lea dx, endl
        mov ah, 09h
        int 21h
        mov ah, 02h
        mov dx,'$'
        int 21h
    lap2:
        pop dx
        int 21h
        loop lap2
    mov ah, 4ch
    int 21h