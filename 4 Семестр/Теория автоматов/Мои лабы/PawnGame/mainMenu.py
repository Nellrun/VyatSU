from mainScreen import *
from core import *
# import os
# import random
# import math
import game		


helpMessage = """
Добро пожаловать в игру PawnGame. Правила очень просты.
Если вы играете за пешку, то ваша задача заключается в том, 
чтобы добраться до конца игровой доски.
Если вы играете за короля, то ваша задача помешать 
пешке добраться до конца поля.

Пешка движется снизу вверх, король движется
сверху вниз.



Игру разработал студент ИВТ-21, Даниил Щесняк. 
Игра выполнена в рамках Теории Автоматов.
"""

def drawSettings(canv):
	# 0 - король, 0 - белый

	def updateCords():
		for i in canv.find_withtag('fig'):
			coords = canv.coords(i)
			config[canv.gettags(i)[0] + 'x'] = (coords[0] - dx)//SIZE + 1
			config[canv.gettags(i)[0] + 'y'] = (coords[1] - dy)//SIZE + 1
		config["color"] = figColor
		saveConfig()

	def updateTexture():
		global kingImg
		global pawnImg
		global wKingImg
		global figColor
		figColor = (figColor + 1) % 2
		kingImg = PhotoImage(file = r'img\king' + str(config["player"] ^ figColor) + '.gif')
		pawnImg = PhotoImage(file = r'img\pawn' + str(int(not config["player"] ^ figColor)) + '.gif')
		wKingImg = PhotoImage(file = r'img\king' + str(int(not config["player"] ^ figColor)) + '.gif')
		canv.itemconfigure(king.id, image = kingImg)
		canv.itemconfigure(pawn.id, image = pawnImg)
		canv.itemconfigure(wKing.id, image = wKingImg)	

	canv.itemconfigure('menuElement', state = 'hidden')

	global kingImg
	global pawnImg
	global wKingImg
	global figColor
	kingImg = PhotoImage(file = r'img\king' + str(config["player"] ^ config["color"]) + '.gif')
	pawnImg = PhotoImage(file = r'img\pawn' + str(int(not config["player"] ^ config["color"])) + '.gif')
	wKingImg = PhotoImage(file = r'img\king' + str(int(not config["player"] ^ config["color"])) + '.gif')

	dx = 450
	dy = 96
	borderWidth = 10
	figColor = config["color"]

	canv.create_rectangle(400, 50, 1100, 650, fill="#fbd3a0", tag = 'settings')
	canv.create_rectangle(dx - borderWidth, dy - borderWidth, dx + 8*SIZE + borderWidth, dy + 8*SIZE + borderWidth, fill = '#3c2418', tag = 'settings')

	# Рисуем крестик
	canv.create_rectangle(1068, 52, 1097, 82, fill = '#fdf5c2', tag = 'closeBut settings')
	canv.create_line(1070, 55, 1095, 80, width = 4, fill = "black", tag = 'closeBut settings')
	canv.create_line(1070, 80, 1095, 55, width = 4, fill = "black", tag = 'closeBut settings')

	# Рисуем галку
	canv.create_rectangle(1035, 52, 1065, 82, fill = '#fdf5c2', tag = 'applyBut settings')
	# canv.create_oval(1035, 52, 1065, 82, fill = '#fdf5c2', tag = 'applyBut settings')
	canv.create_line(1045, 62, 1050, 75, width = 3, fill = "#55AA00", tag = 'applyBut settings')
	canv.create_line(1050, 75, 1058, 57, width = 3, fill = "#55AA00", tag = 'applyBut settings')

	for i in range(0, 8):
		canv.create_text(dx + SIZE*i + (SIZE//2), dy - 25, text = chr(i+97).upper(), font = 'Ravie 15', tag = 'settings')
		canv.create_text(dx - 25, dy + SIZE*i + (SIZE//2), text = i+1, font = 'Ravie 15', tag = 'settings')

	for i in range(0, 8):
		for j in range(0, 8):
			color = '#fbd3a0' if ((j*7)+i) % 2 else "#3c2418"
			canv.create_rectangle(dx + SIZE*i, dy + SIZE*j, dx + SIZE*i + SIZE, dy + SIZE*j + SIZE, fill = color, tag = 'settings')

	# king = canv.create_image(dx + (config["kingx"]-1)*SIZE + SIZE//2, dy + (config["kingy"]-1)*SIZE + SIZE//2, image = kingImg, tag = 'king settings fig')
	# pawn = canv.create_image(dx + (config["pawnx"]-1)*SIZE + SIZE//2, dy + (config["pawny"]-1)*SIZE + SIZE//2, image = pawnImg, tag = 'pawn settings fig')

	# Создание фигур на доске
	pawn = Figure(canv, config["pawnx"]-1, config["pawny"]-1, 'pawn', (config["color"]+1)%2)
	king = Figure(canv, config["kingx"]-1, config["kingy"]-1, 'king', config["color"])
	wKing = Figure(canv, config["wkingx"]-1, config["wkingy"]-1, 'king', (config["color"]+1)%2, 'wking ')

	canv.tag_bind('fig', '<Button-3>', lambda event: updateTexture())

	canv.tag_bind('applyBut', '<Button-1>', lambda event: updateCords() or canv.delete('settings') or canv.delete('fig') or canv.itemconfigure('menuElement', state = 'normal'))
	canv.tag_bind('closeBut', '<Button-1>', lambda event: canv.delete('settings') or canv.delete('fig') or canv.itemconfigure('menuElement', state = 'normal'))

def mainloop():

	canv = Canvas(mainScreen, bg = "white")
	canv.pack(expand = YES, fill = BOTH)
	
	bg = Background(canv)
	startBut = MenuElement(canv, 50, 600, 'Начать игру')
	settingsBut = MenuElement(canv, 50, 625, 'Настройки')
	helpBut = MenuElement(canv, 50, 650, 'Справка')
	exitBut = MenuElement(canv, 50, 675, 'Выход')

	startBut.onClick(lambda event:canv.destroy() or game.mainloop())
	settingsBut.onClick(lambda event: drawSettings(canv))
	helpBut.onClick(lambda event: showMessage(canv, 400, 50, 700, 500, helpMessage))
	exitBut.onClick(lambda event: mainScreen.quit())

	# Запуски циклов жизни
	bg.mainloop()