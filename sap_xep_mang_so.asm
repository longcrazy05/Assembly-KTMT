.model small
.stack 100h
.data
    arr db 1, 6, 127, 23, 3, 7, 8, 34, 24, 50;
    
.code
st:
    mov ax, @data
    mov ds, ax
    
    mov cx, 9
    lap1:
        lea si, arr 
        mov bx, 0
        dec cx
        cmp cx, 0
        je done
        lap2:
            mov al, [si]
            mov ah, [si+1]
            cmp al, ah
            jg swap
            jmp no_swap
            
        swap:
            mov [si], ah
            mov [si+1], al
            inc si
            inc bx
            cmp bx, 9
            jl lap2
            je lap1
        no_swap:
            inc si
            inc bx
            cmp bx, 9
            jl lap2
            je lap1
    done:
        mov si, 0
        lap3:    ; duyet va in
            mov al, arr[si]
            mov ah, 0
            
        print1:
            mov cx, 0
            mov bx, 10
            
            lap4:   ; day tung so vao stack
                mov dx, 0
                div bx         ; ax:bx ==> ax=ax/bx, dx= du
                push dx
                inc cx
                cmp ax, 0
                jg lap4
            lap5:   ;in ra so trong stack    
                 pop dx
                 add dl, '0'    ; chuyen sang ki tu so
                 mov ah, 2
                 int 21h
                 dec cx
                 cmp cx, 0
                 je print2
                 jmp lap5 
        print2:               ; in dau cach va tang si
            mov dl,' '
            int 21h
            inc si
            cmp si, 9
            jng lap3
            jmp done_all
     done_all:    
            mov ah, 4ch
            int 21h
end st;          