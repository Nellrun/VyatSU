;Выполнил студент ИВТ-32 Щесняк Даниил

;Задание:
;Организовать движение шара по экрану со сменой цвета шара после
;касания края экрана

.286
.model small
.data
  x dw 50
  y dw 50
  deltaX dw 1
  deltaY dw 1
  r dw 10
  maxX dw 320
  maxY dw 200
  color db 2
.stack 256h
.code

; Процедура рисования пикселя по координатам, относительно его положения
putPixel proc near
  mov bp, sp
  pusha
    mov ah, 0ch
    mov al, color
    mov dx, y
    add dx, [bp + 4]
    mov cx, x
    add cx, [bp + 2]
    int 10h
  popa
  ret 4
putPixel endp

; Процедура рисования шара
drawCircle proc near
  pusha
  mov ax, r
  mul r
  mov bx, ax ; bx = r^2

  mov si, r
  not si
  inc si ; y = -r
  first_loop:
    mov cx, r
    not cx
    inc cx ; x = -r
    second_loop:
      push si
      mov ax, si
      mul ax ; ax = y ^ 2
      mov si, ax
      mov ax, cx
      mul cx ; ax = x ^ 2
      add ax, si ; ax += y^2
      pop si; ax = x^2 + y^2
      cmp ax, bx
      ja n
        push si
        push cx
        call putPixel
      n:
        inc cx ; x += 1
        mov ax, cx
        mul ax ; ax = x^2
        cmp ax, bx ; cmp x^2 and r^2
        jbe second_loop; while x^2 <= r^2 -> second_loop
        inc si; y += 1
        mov ax, si
        mul ax; y = y^2
        cmp ax, bx;
        jbe first_loop; if while y^2 < r^2 -> first_loop
  popa
  ret
drawCircle endp

; Функция складывающая текущее положение круга с вектором его направления
nextStep proc near
  mov ax, x
  add ax, deltaX
  mov x, ax

  mov ax, y
  add ax, deltaY
  mov y, ax

  ret
nextStep endp

;Проверяем столкновение шара со стенками
checkCollision proc near
  pusha
  mov ax, x
  sub ax, r
  jnz nl ; Левая стенка
  not deltaX
  inc deltaX
  inc color
  nl:
    mov ax, x
    add ax, r; Правая стенка
    cmp ax, maxX
    jne nr
    not deltaX
    inc deltaX
    inc color
  nr:
    mov ax, y
    sub ax, r
    jnz nu; Потолок
    not deltaY
    inc deltaY
    inc color
  nu:
    mov ax, y
    add ax, r
    cmp ax, maxY
    jne nd; Пол
    not deltaY
    inc deltaY
    inc color
  nd:
    popa
    ret
checkCollision endp

;Процедура выполняющая очистку экрана
clearScreen proc near
  mov ah, 0h
  mov al, 0dh
  int 10h
  ret
clearScreen endp
main:
  mov ax,@data
  mov ds,ax

; Главный цикл программы
  main_loop:
    call clearScreen; Очистка экрана
    call drawCircle; Рисуем шар на экране
    call checkCollision; Проверяем его столкновение с границами
    call nextStep; Делаем шаг вперед

    ;Ждем следующего действия пользователя
    mov ah, 0h
    int 16h

    cmp al, 63h
    jne main_loop
  ;Сбрасываем режим экрана на текстовый
  mov ah, 0h
  mov al, 2h
  int 10h
  ;Завершаем работу программы
  mov ah, 4ch
  int 21h
end main
