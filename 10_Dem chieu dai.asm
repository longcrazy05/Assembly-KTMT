.model small
.stack 100h
.data
    str db "Hello World 123!$"   
    ms db "Chieu dai chuoi la: ","$"
.code
st:
    mov ax, @data
    mov ds, ax
    
    mov ah, 9
    lea dx, ms   
    int 21h
    
    lea si, str
    mov cx, 0 
    mov bx, 10
    
    lap: 
        mov al, [si]
        cmp al, '$'
        je donelap
        inc si
        inc cx
        jmp lap
    donelap:
        mov ax, cx
        mov cx, 0
        jmp lap2
    lap2:
        mov dx, 0       ;
        div bx
        push dx
        inc cx
        cmp ax, 0
        je lap3
        jmp lap2
    lap3:
        pop dx
        add dl, '0'
        mov ah, 2
        int 21h
        dec cx
        cmp cx, 0
        je done
        jmp lap3
    done:    
        mov ah, 4ch
        int 21h
end st