.model small
.stack 100h
.data
    msg DB "Hello World!$"      
    endl DB 13, 10, '$'
.code
start:
    mov ax, @data
    mov ds, ax
       
    mov ah, 09h
    ;in xuong dong
    lea dx, endl
    int 21h
    ;in loi chao 
    lea dx, msg
    int 21h            
    
    
    ;ket thuc
    mov ah, 4ch
    int 21h
end start