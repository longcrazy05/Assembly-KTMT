.model small
.stack 100h
.data
    str db 100
        db 0
        db 100 dup('$')  
    ms2 db 100 dup('$')
    ms3 db 100 dup('$')
    
    vt db 13, 10, 'viet thuong: ', '$'
    vh db 13, 10, 'viet hoa: ', '$'
.code
    mov ax, @data
    mov ds, ax
    
    mov ah, 0ah
    lea dx, str
    int 21h
    
    mov cl, str+1
    lea si, str+2
    lea di, ms2
    lap1:
        mov al, [si]
        cmp cl, 0
        je done1
        cmp al, 'a'
        jl lower
        mov [di], al
        inc di
        inc si
        dec cl
        jmp lap1
        lower:
            add al, 32;
            mov [di], al;
            inc di
            inc si 
            dec cl
            jmp lap1
    done1:
        lea si, ms2 
        lea di, ms3
        jmp lap2
    lap2:
        mov al, [si]
        cmp al, '$'
        je done2
        sub al, 32
        mov [di], al
        inc si
        inc di
        jmp lap2
    done2:
        mov ah, 09h
        lea dx, vt
        int 21h
        lea dx, ms2
        int 21h
        
        lea dx, vh
        int 21h
        
        lea dx, ms3
        int 21h
        
        mov ah, 4ch
        int 21h
end
            