.model small
.stack 100h
.data
     ms db 'nhap n: $'
     endl db 13, 10, '$' 
     str db 5 dup ('$')
     
.code
start:
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, ms;
    int 21h
    
    mov ah, 0ah
    lea dx, str
    int 21h
    
    mov ch, 0
    mov cl, str+1
    mov bx, 10
    mov ax, 0
    lea si, str+2 
    
    lap1:
        mul bx
        mov dl, [si]
        sub dl,'0'
        add ax, dx
        inc si
        dec cx
        cmp cx, 0
        je done1 
        jmp lap1
    done1:
        mov cx, ax 
        mov bx, 1
        mov ax, 0
    lap2:
        add ax, bx
        inc bx
        cmp bx, cx
        jg done2
        jmp lap2
    done2:
        mov bx, 10
        mov cx, 0
    lap3:
        mov dx, 0
        div bx
        push dx
        inc cx
        cmp ax, 0
        je done3
        jmp lap3
    done3:
        mov ah,09h
        lea dx, endl
        int 21h
    lap4:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        dec cx
        cmp cx, 0
        je done_all
        jmp lap4
    done_all:
        mov ah, 4ch
        int 21h
end start
    
    