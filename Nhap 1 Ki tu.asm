.model small
.stack 100h
.data
    msg db "Nhap 1 ky tu: $"
    endl db 13, 10, '$'
    char db ''
.code
start:
    mov ax, @data
    mov ds, ax

    ; In th�ng b�o
    mov ah, 09h
    lea dx, msg
    int 21h

    ; doc 1 ki tu tu ban phim
    mov ah, 01h
    int 21h
    ; ky tu duoc luu trong al 
    mov [char], al  ; luu ki tu da nhap vao char
    
    ; in xuong dong
    mov ah, 09h
    lea dx, endl;
    int 21h
    
    ; in ki tu vua nhap
    mov ah, 02h
    mov dl, [char]
    int 21h

    ; Tho�t
    mov ah, 4Ch
    int 21h

end start
