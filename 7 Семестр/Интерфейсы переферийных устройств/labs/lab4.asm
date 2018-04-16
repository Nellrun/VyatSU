.model small
.data
	str db 1Bh, 40h, 'Shchesnyak Daniil IVT-42', 0Ah, 0Dh
	db 1Bh, 53h, 0, 'Up index', 1Bh, 54h, 0Ah, 0Dh
	db 1Bh, 53h, 1, 'Down index', 1Bh, 54h, 0Ah, 0Dh
	db 1Bh, 2Dh, 1, 'Underline', 1Bh, 2Dh, 0Ah, 0Dh
	db 1Bh, 47h, 'Double print', 1Bh, 48h, 0Ah, 0Dh
	db 1Bh, 78h, 1, 'NLQ mode', 1Bh, 48h, 0Ah, 0Dh, 'NLQ off', 0Ah, 0Dh
	db 1Bh, 57h, 1, 'Double width', 1Bh, 57h, 0, 0Ah, 0Dh
	db 1Bh, 4Dh, '12 symbols per inch', 0Ah, 0Dh
	db 1Bh, 50h, '10 symbols per inch', 0Ah, 0Dh
	db 1Bh, 0Fh, 'Pressed text', 12h, 0Ah, 0Dh
	db 1Bh, 30h, '1/8 inch between lines', 0Ah, 0Dh
	db 1Bh, 30h, '1/8 inch between lines', 0Ah, 0Dh
	db 1Bh, 30h, '1/8 inch between lines', 0Ah, 0Dh
	db 1Bh, 31h, '1/10 inch between lines', 0Ah, 0Dh
	db 1Bh, 31h, '1/10 inch between lines', 0Ah, 0Dh
	db 1Bh, 31h, '1/10 inch between lines', 0Ah, 0Dh
	db 1Bh, 32h, '1/6 inch between lines', 0Ah, 0Dh
	db 1Bh, 32h, '1/6 inch between lines', 0Ah, 0Dh
	db 1Bh, 32h, '1/6 inch between lines', 0Ah, 0Dh
	db 1bh, 31h	
	db 1bh, 2ah, 0, 32, 0
	db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 15, 127
	db 255, 127, 15, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	db 1bh, 2ah, 0, 32, 0
	db 28, 28, 30, 31, 31, 31, 31, 29, 28, 28, 28, 60, 252, 252
	db 224, 0, 224, 252, 252, 60, 28, 28, 28, 29, 31, 31, 31, 31, 30 
	db 28, 28, 24
	db 1bh, 2ah, 0, 32, 0
	db 0, 0, 0, 0, 128, 128, 192, 225, 239, 255, 126, 48, 1, 3, 7, 7, 7
	db 3, 1, 48, 126, 255, 255, 225, 192, 128, 128, 0, 0, 0, 0, 0
	db 1bh, 2ah, 0, 32, 0
	db 0, 0, 0, 0, 0, 7, 62, 252, 252, 248, 240, 240, 224, 192, 128, 128
	db 128, 192, 224, 224, 240, 248, 252, 252, 62, 7, 0, 0, 0, 0, 0, 0
	lengthString equ $ - str
.code
MAIN:
	mov ax, @data
	mov ds, ax
	mov ah, 40h
	mov bx, 04h
	mov cx, lengthString
	lea dx, str
	int 21h
	mov ah, 00h
	int 16h
	mov ah, 4Ch
	int 21h
end MAIN