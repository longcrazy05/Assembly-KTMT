.model small
.stack 100h
.data
    str db 100        ; 
        db ?          ; 
        db 100 dup('$') ; 
    endl db 13, 10, '$'
.code
st:
    mov ax, @data
    mov ds, ax
    
    ;nhap chuoi
    mov ah, 0ah
    lea dx, str
    int 21h
    
    mov ah, 09h
    lea dx, endl
    int 21h
    
    ; in chuoi nguoc
    lea si, str+2         ; si tro toi ki tu dau 
    mov cl, [str+1]       ; CL chua sl tu da nhap
    mov ch, 0
    add si, cx            ; SI tro ngay sau ki tu cuoi
    dec si                ; lui ve ki tu cuoi
     
lap:
    lea dx, str+2
    cmp si, dx            ; 
    jb done
    
    mov dl, [si]          ; 
    mov ah, 02h
    int 21h               ;
    
    dec si
    jmp lap

done:
    mov ah, 4ch
    int 21h
end st