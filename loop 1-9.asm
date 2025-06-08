.model small
.stack 100h
.data
    ms1 db 'xuat cac so tu 1-9', 13, 10, '$'
    ms2 db 13, 10, '$'
    char db '1'
.code
st:
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, ms1
    int 21h
   
    mov cx, 9;
    
    lap:
        mov dl, char
        mov ah, 02h
        int 21h
        
        inc char
        
        mov ah, 09h
        lea dx, ms2
        int 21h
        loop lap
    mov ah, 4ch
    int 21h
end st