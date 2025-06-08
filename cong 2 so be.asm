.model small
.stack 100h
.data 
       ms1 db 'nhap so a: $'
       ms2 db 13, 10, 'nhap so b: $'
       ms3 db 13, 10, 'tong 2 so la: $'
       a db ?
       b db ? 
       c db ?
.code
st:
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, ms1
    int 21h
    
    mov ah, 01h
    int 21h
    mov a, al
    
    mov ah, 09h
    lea dx, ms2
    int 21h
    
    mov ah, 01h
    int 21h
    mov b, al
    
    sub a, 48
    sub b, 48
    mov al, a
    mov c, al 
    mov al, b
    add c, al
    
    mov ah, 09h
    lea dx, ms3
    int 21h
    
    mov ah, 02h
    mov dl, c
    add dl, 48
    int 21h
    
    mov ah, 4ch
    int 21h
end st       