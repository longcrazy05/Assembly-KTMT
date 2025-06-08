.model small
.stack 100h
.data
    char db ?
    endl db 13, 10, '$'  
    msg db 'nhap mot ki tu thuong: $' 
    ms2 db 'ki tu viet hoa la: $'
.code
st:
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, msg
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov [char], al
    sub char, 32
    
    mov ah, 09h
    lea dx, endl
    int 21h
    lea dx, ms2
    int 21h
    
    mov ah, 02h
    mov dl, char
    int 21h
    
    mov ah, 4ch
    int 21h
end st