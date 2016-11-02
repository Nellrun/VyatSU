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
		path = 'bg/' + random.choice(self.imageList)
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
		self.id = self.canv.create_text(x, y, text = text, anchor = 'nw', font = 'Arial 15 italic bold', fill = '#000000', tag = 'menuElement')
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

class PopupMessage(object):
	"""docstring for PopupMessage"""
	def __init__(self, canv, x, y, width, height, message):
		super(PopupMessage, self).__init__()
		message = message.split('\n')

		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.canv = canv
		if width < (len(message[0]) * 13):
			self.width = len(message[0]) * 13
		self.id = self.canv.create_rectangle(x - 3, y - 3, x + self.width + 3, y + height + 3, fill = "white", tag = "popupMessage")
		self.canv.create_rectangle(x, y, x + self.width, y + height, fill = "black", tag = "popupMessage" + str(self.id))

		for i, line in enumerate(message):
			self.canv.create_text(x + 25, (y + 3) + 15 * i, text = line, anchor = 'nw', fill = "white", font = "Arial 13 italic bold", tag = ("popupMessage" + str(self.id), 'Text'))
		self.canv.itemconfig(self.id, tag = ("popupMessage" + str(self.id), "border"))

	def move(self, dx, dy):
		x = self.x + dx
		y = self.y + dy
		c = math.hypot(x - self.x, y - self.y)
		if c > 1:
			self.x += round(dx / c)
			self.y += round(dy / c)
			dx -=  dx/c
			dy -= dy/c 
			self.canv.move("popupMessage" + str(self.id), round((x - self.x) / c), round((y - self.y) / c))
			self.canv.after(40, lambda : self.move(dx, dy))

	def show(self, dx, dy, time):
		self.move(dx, dy)
		self.canv.after(time, lambda : self.move(-dx, -dy))

	def onClick(self, func):
		self.canv.tag_bind("popupMessage" + str(self.id), "<Button - 1>", lambda x: func(x));


def showMessage(canv, x, y, width, height, message):
	message = message.split('\n')

	# canv.create_rectangle(400, 50, 1100, 650, fill="#fbd3a0", tag = 'showMessage')
	canv.create_rectangle(x - 3, y - 3, x + width + 3, y + height + 3, fill = "white", tag = 'showMessage')
	canv.create_rectangle(x, y, x + width, y + height, fill="#000000", tag = 'showMessage')
	# canv.create_rectangle(dx - borderWidth, dy - borderWidth, dx + 8*SIZE + borderWidth, dy + 8*SIZE + borderWidth, fill = '#3c2418', tag = 'settings')

	# Рисуем крестик
	# canv.create_rectangle(x + width - 32, y + 2, x + width - 3, y + 32, fill = '#fdf5c2', tag = 'closeBut showMessage')
	canv.create_line(x + width - 15, y + 5, x + width - 5, y + 15, width = 4, fill = "red", tag = 'closeBut showMessage')
	canv.create_line(x + width - 15, y + 15, x + width - 5, y + 5, width = 4, fill = "red", tag = 'closeBut showMessage')

	# canv.create_rectangle(x + width - 50, y + height - 30, x + width - 10, y + height - 5, fill = '#fdf5c2', tag = 'closeBut showMessage')
	# canv.create_text(x + width - 50, y + height - 30, text = 'OK', anchor = 'nw', font = 'Arial 15 italic bold', tag = 'closeBut showMessage')

	for i, j in enumerate(message):
		canv.create_text(x + 25, y + 50 + 25*i, text = j, anchor = 'nw', font = 'Arial 15 italic bold', fill = 'white', tag = 'showMessage')

	canv.tag_bind('closeBut', '<Button-1>', lambda x: canv.delete('showMessage'))
	canv.tag_bind('closeBut', '<B1-Motion>', lambda x: canv.itemconfig('closeBut', fill = '#FF0000'))

class InputDialog(object):
	"""docstring for InputDialog"""
	def __init__(self):
		super(InputDialog, self).__init__()
		self.top = Toplevel(mainScreen)
		self.top.config(width = 100, height = 50)
		Label(self.top, text = "Nickname: ").pack()
		self.e = Entry(self.top)
		self.e.pack(padx = 5)
		self.e.config(selectborderwidth = 0)
		self.okBut = Button(self.top, text = "OK", width = 20)
		self.okBut.pack(pady = 5)
		
	def onClick(self, func):
		self.okBut.config(command = (lambda: func(self)))
		
