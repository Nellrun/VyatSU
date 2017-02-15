.model small
.data
message db 'Number:$'
line db 5h
.stack 256h
.code
main:
mov ax,@data
mov ds,ax
lea dx,message
mov ah,09h ; Выводим текст
int 21h
call readLine ; Считываем строку
mov ah,4ch
int 21h

readLine:
  lea bx, line
  mov ah, 0
  startLoop:
    int 16h
    mov [bx], al
    inc bx
    sub al, 0ah
    jz startLoop
end main
