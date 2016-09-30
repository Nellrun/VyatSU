from tkinter import *
import os
import random
import math
from mainScreen import *
# CONSTS
SIZE = 64
DX = 450
DY = 96

# Вспомогательные функции
def absToRel(point):
	return [int((point[0] - DX)//SIZE), int((point[1] - DY)//SIZE)]

class Background(object):
	"""background class"""
	def __init__(self, canv):
		super(Background, self).__init__()
		self.canv = canv
		self.isMoveRight = True
		self.dx = 1
		self.dy = 0
		self.imageList = list(filter(lambda x : x.endswith('.gif'), os.listdir('bg')))
		path = 'bg\\' + random.choice(self.imageList)
		self.img = PhotoImage(file = path).zoom(round(WIDTH/width), round(WIDTH/width))
		self.id = self.canv.create_image(-200, 0, image = self.img, anchor = 'nw', tag = 'background')

	def changeImage(self):
		path = 'bg\\' + random.choice(self.imageList)
		self.img = PhotoImage(file = path).zoom(round(WIDTH/width), round(WIDTH/width))
		self.canv.itemconfigure(self.id, image = self.img)
		pColor = self.img.get(1, 1)
		# self.canv['bg'] = '#' + str(pColor[0]) + str(pColor[1]) + str(pColor[2])


	def changeState(self):
		if self.canv.coords(self.id)[0] > 0 and self.isMoveRight:
			self.isMoveRight = False
			self.dx = -1
			self.changeImage()
		elif self.canv.coords(self.id)[0] < -200 and not self.isMoveRight:
			self.isMoveRight = True
			self.dx = 1
			self.changeImage()

	def mainloop(self):
		try:
			self.changeState()
			self.canv.move(self.id, self.dx, self.dy)
			self.canv.after(50, self.mainloop)	
		except:
			pass

class MenuElement(object):
	"""docstring for menuElement"""
	def __init__(self, canv, x, y, text):
		super(MenuElement, self).__init__()
		self.canv = canv
		self.x = x
		self.y = y
		self.color = 255
		self.leave = True
		self.id = self.canv.create_text(x, y, text = text, anchor = 'nw', font = 'Arial 15 italic bold', fill = 'brown', tag = 'menuElement')
		# self.tag = 'menu' + self.id
		# self.canv.create_rectangle(x, y, x + 100, y + 20, fill = 'gray')
		self.canv.tag_bind(self.id, '<Motion>', lambda event: self.move(self.x + 40, 0))
		self.canv.tag_bind(self.id, '<Leave>', lambda event: self.moveBack())
		# self.canv.tag_bind(self.id, '<B1-Motion>', self.drag)

	def move(self, x, y):
		coords = self.canv.coords(self.id)
		sign = math.copysign(1, x - coords[0])
		self.canv.move(self.id, 1*sign, 0)
		if coords[0] < x:
			self.canv.after(10, lambda : self.move(x, y))

	def moveBack(self):
		coords = self.canv.coords(self.id)
		sign = math.copysign(1, self.x - coords[0])
		self.canv.move(self.id, 1*sign, 0)
		if coords[0] != self.x:
			self.canv.after(10, lambda : self.moveBack())

	def drag(self, event):
		self.canv.coords(self.id, event.x, event.y)

	def onClick(self, func):
		self.canv.tag_bind(self.id, '<Button-1>', func)

class Figure(object):
	"""docstring for Figure"""
	def __init__(self, canv, x, y, type, color, addType = ''):
		super(Figure, self).__init__()
		self.x = x
		self.y = y
		self.color = color
		self.img = PhotoImage(file = 'img\\' + type + str(color) + '.gif')
		# self.SIZE = SIZE
		self.canv = canv
		self.id = canv.create_image(DX + x*SIZE + SIZE//2, DY + y*SIZE + SIZE//2, image = self.img, tag = addType + type + ' fig')
		
		# if (color == config["player"]):
		self.canv.tag_bind(self.id, '<Button1-Motion>', lambda event: canv.coords(self.id, event.x, event.y))
		self.canv.tag_bind(self.id, '<ButtonRelease-1>', lambda event: self.checkCoords(event.x, event.y))

	def checkCoords(self, x, y):
		dx = 450
		dy = 96
		self.x = (x - DX)//SIZE
		self.y = (y - DY)//SIZE
		if self.x > 7:
			self.x = 7
		if self.x < 0:
			self.x = 0
		if self.y > 7:
			self.y = 7
		if self.y < 0:
			self.y = 0
		self.canv.coords(self.id, DX + self.x*SIZE + SIZE//2, DY + self.y*SIZE + SIZE//2)

def showMessage(canv, x, y, width, height, message):
	message = message.split('\n')

	# canv.create_rectangle(400, 50, 1100, 650, fill="#fbd3a0", tag = 'showMessage')
	canv.create_rectangle(x, y, x + width, y + height, fill="#fbd3a0", tag = 'showMessage')
	# canv.create_rectangle(dx - borderWidth, dy - borderWidth, dx + 8*SIZE + borderWidth, dy + 8*SIZE + borderWidth, fill = '#3c2418', tag = 'settings')

	# Рисуем крестик
	canv.create_rectangle(x + width - 32, y + 2, x + width - 3, y + 32, fill = '#fdf5c2', tag = 'closeBut showMessage')
	canv.create_line(x + width - 30, y + 5, x + width - 5, y + 30, width = 4, fill = "black", tag = 'closeBut showMessage')
	canv.create_line(x + width - 30, y + 30, x + width - 5, y + 5, width = 4, fill = "black", tag = 'closeBut showMessage')

	canv.create_rectangle(x + width - 50, y + height - 30, x + width - 10, y + height - 5, fill = '#fdf5c2', tag = 'closeBut showMessage')
	canv.create_text(x + width - 50, y + height - 30, text = 'OK', anchor = 'nw', font = 'Arial 15 italic bold', tag = 'closeBut showMessage')

	for i, j in enumerate(message):
		canv.create_text(x + 25, y + 50 + 25*i, text = j, anchor = 'nw', font = 'Arial 15 italic bold', fill = 'black', tag = 'showMessage')

	canv.tag_bind('closeBut', '<Button-1>', lambda x: canv.delete('showMessage'))
