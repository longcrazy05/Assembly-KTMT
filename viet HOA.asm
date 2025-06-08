.model small
.stack 100h
.data
    str db 'hello$'
    str2 db 100 dup('$')
.code
st:
    mov ax, @data
    mov ds, ax
    
    lea si, str  
    lea di, str2
    lap:
       mov al, [si]
       cmp al, '$'
       je done
       
       sub al, 32
       mov [di], al
       inc si
       inc di
       jmp lap
    done:
        mov ah, 09h
        lea dx, str2
        int 21h
        mov ah, 4ch
        int 21h 
end st        