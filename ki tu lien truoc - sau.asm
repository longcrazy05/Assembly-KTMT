.model small
.stack 100h
.data
    ms1 db 'nhap 1 ki tu: $'
    ms2 db 'ki tu lien truoc la: $'
    ms3 db 'ki tu lien sau la: $'
    endl db 13, 10, '$'
    char db ?
    char2 db ?
    char3 db ?
.code
st:
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, ms1
    int 21h
    
    mov ah, 01h
    int 21h
    
    mov [char], al
    sub al, 1
    mov [char2], al
    add al, 2
    mov char3, al
    
    mov ah, 09h
    lea dx, endl
    int 21h
    lea dx, ms2
    int 21h
    
    mov ah, 02h
    mov dl, char2
    int 21h
    
    mov ah, 09h
    lea dx, endl
    int 21h
    lea dx, ms3
    int 21h
    
    mov ah, 02h
    mov dl, char3
    int 21h
    
    mov ah, 4ch
    int 21h
end st