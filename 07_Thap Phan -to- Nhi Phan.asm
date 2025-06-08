.model small
.stack 100
.data 
    ms1 db "Nhap 1 so thap phan: $"
    ms2 db 13, 10, "Chuyen sang nhi phan: $"
    str db 3 dup('$')
    
.code
start:
    mov ax, @data
    mov ds, ax
    
    ; In thong bao
    mov ah, 9
    lea dx, ms1
    int 21h
    
    ; Doc chuoi
    mov ah, 0ah
    lea dx, str
    int 21h
    
    ; Chuyen chuoi thanh so
    mov cl, str+1      ; so ky tu nhap
    mov ch, 0
    lea si, str+2      ; tro den ky tu dau tien
    mov ax, 0
    mov bx, 10
    
lap1:
    mul bx             ; AX = AX * 10
    mov dl, [si]
    sub dl, '0'
    add al, dl
    inc si
    dec cl
    cmp cl, 0
    jne lap1

    ; Chuyen sang nhi phan
    mov bx, 2
    mov cx, 0
lap2:
    mov dx, 0        ; clear dx truoc khi chia
    div bx           ; ax : bx -> ax = thuong, dx = du
    push dx
    inc cx           
    cmp ax, 0
    jg lap2

    ; In thong bao ket qua
    mov ah, 9
    lea dx, ms2
    int 21h

    ; In nhi phan
lap3:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    dec cx
    cmp cx, 0     
    jg lap3

    ; Ket thuc
done3:
    mov ah, 4ch
    int 21h
end start
