.model small
.stack 100h
.data
    arr db 5, 19, 13, 4, 12, 27, 123, 8, 6
    arr_size equ 9
    min db ?
    max db ?
    ms1 db "Gia tri lon nhat: $"
    ms2 db 13, 10, "Gia tri nho nhat: $"   
.code
st:
    mov ax, @data
    mov ds, ax
    
    mov al, arr[0]
    mov max, al
    mov min, al  
    
    mov cx, arr_size
    mov si, 1

find_loop:
    cmp si, cx
    jge done_find
    mov al, arr[si] 
    
    cmp al, max
    jg update_max
    
    cmp al, min
    jl update_min
    jmp next

update_max:
    mov max, al
    jmp next

update_min:
    mov min, al

next:
    inc si
    jmp find_loop

done_find:
    mov ah, 09h
    lea dx, ms1
    int 21h

    mov ax, 0
    mov al, max
    call PrintNumber

    mov ah, 09h
    lea dx, ms2
    int 21h

    mov ax, 0
    mov al, min
    call PrintNumber

    mov ah, 4ch
    int 21h

PrintNumber proc
    mov ah, 0         
    mov bx, 10
    xor cx, cx        

divide_loop:
    xor dx, dx
    div bx            
    push dx
    inc cx
    cmp ax, 0
    jne divide_loop

print_loop:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop print_loop
    ret
PrintNumber endp
end st
