.model small
.stack 100h
.data
    str db 'Hello123$'
.code
st:
    mov ax, @data
    mov ds, ax
    
    lea si, str
    lap:
        mov al, [si]
        cmp al, '$'
        je done
        
        mov ah, 02h
        mov dl, al
        int 21h
        
        inc si
        jmp lap
    done:
        mov ah, 4ch
        int 21h
end st