.model small
.stack 100h
.data
    str db 101
        db 0
        db 101 dup('$')
    endl db 13, 10, '$'
.code
start:
    mov ax, @data
    mov ds, ax
    
    mov ah, 0ah
    lea dx, str
    int 21h
    
    mov ah, 09h
    lea dx, endl
    int 21h
    
    mov ah, 09h
    lea dx, str+2
    int 21h
    
    mov ah, 4ch
    int 21h
end start