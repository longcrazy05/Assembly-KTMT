.model small
.stack 100h
.data
    board db '1','2','3','4','5','6','7','8','9'
    player db 'X'

    endl db 13, 10, '$'
    msg_turn db 'Turn of player $'
    msg_xwin db 'Player X wins!$'
    msg_owin db 'Player O wins!$'
    msg_draw db 'No player wins!$'
    msg_replay db 'Play again ?(y/n): $' 
    msg_sure db 'Are you sure ?(y/n): $'

.code
main:
    mov ax, @data
    mov ds, ax
    mov cx, 0

start_game:
    ;call clear_screen
    ;call draw_board
    call player_turn
    call check_win
    call switch_player
    jmp start_game

;-----------------------------------------------------
clear_screen proc
    mov ah, 0
    mov al, 3
    int 10h
    ret
clear_screen endp

;-----------------------------------------------------
move_cursor proc     ; di chuyen vi tri con tro 
    ; INPUT: dh = row , dl = column
    mov ah, 02h
    mov bh, 0
    int 10h
    ret
move_cursor endp

;-----------------------------------------------------
draw_board proc
    ;dh = row, dl = column 
    mov dh, 8           ; vi tri con tro hang 1
    mov dl, 37
    call move_cursor

    lea si, board

    call draw_row       ; ve hang 1
    call draw_line      ; ve dong ke duoi hang 1

    mov dh, 10          ; vi tri con tro hang 2
    mov dl, 37
    call move_cursor

    call draw_row       ; ve hang 2
    call draw_line      ;

    mov dh, 12
    mov dl, 37
    call move_cursor

    call draw_row

    ret
draw_board endp

;-----------------------------------------------------
draw_row proc
    ;
    mov al, [si]
    call print_colored        ; chon mau cho ki tu
    mov dl, al
    call print_char

    mov dl, '|'
    call print_char

    inc si                    ; tang si de tro toi vi tri tiep
    mov al, [si]
    call print_colored
    mov dl, al
    call print_char

    mov dl, '|'
    call print_char

    inc si
    mov al, [si]
    call print_colored
    mov dl, al
    call print_char

    inc si
    ret
draw_row endp

;-----------------------------------------------------
draw_line proc
    ; xuong dong
    inc dh
    mov dl, 37
    call move_cursor

    ; ve -+-+-
    mov dl, '-'
    call print_char
    mov dl, '+'
    call print_char
    mov dl, '-'
    call print_char
    mov dl, '+'
    call print_char
    mov dl, '-'
    call print_char

    ret
draw_line endp
;-----------------------------------------------------
print_char proc            ; ham in ki tu trong dl
    mov ah, 02h
    int 21h
    ret
print_char endp
;-----------------------------------------------------
print_colored proc         ; chon mau cho ki tu in ra(nhung ko in)
    cmp al, 'X'
    je print_x
    cmp al, 'O'
    je print_o

    mov bl, 0Fh
    jmp print_common

print_x:
    mov bl, 0Ch ; Ðo sáng
    jmp print_common

print_o:
    mov bl, 0Ah ; Xanh lá sáng

print_common:
    push cx
    mov ah, 09h
    mov bh, 0
    mov cx, 1
    int 10h
    pop cx
    ret
print_colored endp
;-----------------------------------------------------
player_turn proc
    ; Thông báo luot choi
ms_turn:
    call clear_screen
    call draw_board
    mov dh, 14
    mov dl, 31
    call move_cursor

    mov ah, 09h
    lea dx, msg_turn
    int 21h

    ; In nguoi choi
    mov dl, player
    mov ah, 02h
    int 21h
    mov dl, ':'
    int 21h

input_loop:
    ; nhap vi tri
    mov ah, 01h
    int 21h
    sub al, '1'               ; kiem tra co phai so 1,2,..9
    cmp al, 0
    jl ms_turn                ; neu ko phai-> nhap lai
    cmp al, 8
    jg ms_turn
    ; neu la so
    mov bl, al                 ; kiem tra o da danh chua
    lea si, board
    add si, bx
    mov al, [si]
    cmp al, 'X'
    je ms_turn                 ; neu da danh -> nhap lai
    cmp al, 'O'
    je ms_turn

    ; neu chua danh
    mov dh, 16
    mov dl, 31
    call move_cursor
    
    mov ah, 9
    lea dx, msg_sure
    int 21h
    
    mov ah, 1
    int 21h 
    
    cmp al, 'n' 
    je ms_turn            
  
    mov al, player
    mov [si], al
    inc cx
    ret
       
player_turn endp

;-----------------------------------------------------
check_win proc
    ; kt row
    lea si, board           ; vi tri dau tien cua board
    mov al, [si]
    cmp al, [si+1]
    jne check_row2          ; neu ko bang -> kt row2
    cmp al, [si+2]
    jne check_row2
    call win_game           ; neu giong nhau -> tb win

check_row2:
    lea si, board
    add si, 3
    mov al, [si]
    cmp al, [si+1]
    jne check_row3           ; neu ko bang -> kt row3
    cmp al, [si+2]
    jne check_row3
    call win_game            ; neu

check_row3:
    lea si, board
    add si, 6
    mov al, [si]
    cmp al, [si+1]
    jne check_col1         ; neu ko bang -> kt col1
    cmp al, [si+2]
    jne check_col1
    call win_game

; kt col
check_col1:
    lea si, board
    mov al, [si]
    cmp al, [si+3]
    jne check_col2
    cmp al, [si+6]
    jne check_col2
    call win_game

check_col2:
    lea si, board
    add si, 1
    mov al, [si]
    cmp al, [si+3]
    jne check_col3
    cmp al, [si+6]
    jne check_col3
    call win_game

check_col3:
    lea si, board
    add si, 2
    mov al, [si]
    cmp al, [si+3]
    jne check_diag1
    cmp al, [si+6]
    jne check_diag1
    call win_game

; kt duong chéo
check_diag1:
    lea si, board
    mov al, [si]
    cmp al, [si+4]
    jne check_diag2
    cmp al, [si+8]
    jne check_diag2
    call win_game

check_diag2:                  ; truong hop cuoi cung 
    lea si, board
    add si, 2
    mov al, [si]
    cmp al, [si+2]
    jne continue_game
    cmp al, [si+4]
    jne continue_game
    call win_game

continue_game:
    cmp cx, 9              ; kiem tra da danh het o chua
    je draw_game           ; neu het -> tb hoa
    ret
check_win endp

;-----------------------------------------------------
switch_player proc
    cmp player,'X'
    je switch_to_o
    mov player,'X'
    ret
switch_to_o:
    mov player,'O'
    ret
switch_player endp

;-----------------------------------------------------
win_game proc
    push ax                 ;do clear_sceen + draw_board thay doi ah
    call clear_screen
    call draw_board
    pop bx
    ; Thông báo win
    mov dh, 14
    mov dl, 33
    call move_cursor

    cmp bl, 'X'             ; kt nguoi choi la X
    je xwin
    mov ah, 09h
    lea dx, msg_owin
    int 21h
    jmp replay
xwin:
    mov ah, 09h
    lea dx, msg_xwin
    int 21h
    jmp replay              ; nhay den replay
win_game endp

;-----------------------------------------------------
draw_game:
    call clear_screen
    call draw_board

    ; Thông báo hòa
    mov dh, 14
    mov dl, 33
    call move_cursor

    mov ah, 09h
    lea dx, msg_draw
    int 21h
    jmp replay
;------------------------------------------------------

replay:
    mov dh, 16
    mov dl, 31
    call move_cursor
    
    mov ah, 9
    lea dx, msg_replay
    int 21h
    
    mov ah, 1
    int 21h
    
    cmp al, 'y'             ; neu nhap y -> choi lai
    je reset
    cmp al, 'n'             ; neu nhap n -> thoat
    je exit
    jmp replay              ; neu nhap ko phai y/n -> nhap lai
reset:                      ; reset ban co va nguoi choi 
    lea si, board
    mov al, '1'
    mov cx, 9
    fill:
        mov [si], al
        inc si
        inc al
        loop fill
    mov player, 'X'         ; nguoi choi khoi dau la X
    jmp start_game          ; bat dau lai
exit:
    mov ah, 4Ch
    int 21h

;----------------------------------------------------
end main
