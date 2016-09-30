from mainScreen import *
from core import *
import time
import mainMenu
import numpy as np

def ceil(x):
    if x == 0:
        return 0
    return int(x / abs(x))

class Pawn(Figure):
    """docstring for Pawn"""
    def __init__(self, canv, x, y, color):
        super(Pawn, self).__init__(canv, x, y, 'pawn', color)
        # if (color != config["player"]):
            # self.canv.tag_unbind(self.id, '<Button1-Motion>')
            # self.canv.tag_unbind(self.id, '<ButtonRelease-1>')

    def checkCoords(self, absX, absY):
        global STEP
        global pause
        global STOP
        x = (absX - DX) // SIZE
        y = (absY - DY) // SIZE
        a = self.canv.find_withtag('wKing')[0]
        king = self.canv.find_withtag('bKing')
        kPoint = absToRel(self.canv.coords(king));
        point = absToRel(self.canv.coords(a))
        if (self.y == 6) and (self.y - y == 2) and (x == self.x) and (point != [x, y]) and (kPoint != [x, y]) and not (pause) and not (STOP):
            self.y = y
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            STEP = False
            return
        if (0 <= x <= 7) and (0 <= y <= 7) and (not (pause)) and (not (STOP)) and ( (x != self.x) or (y != self.y) ):
            a = self.canv.find_withtag('bKing')[0]
            point = absToRel(self.canv.coords(a))
            if ([x, y] == point):
                showMessage(self.canv, 500, 300, 300, 150, 'Запрещенный ход')
                self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
                return False
            a = self.canv.find_withtag('wKing')[0]
            point = absToRel(self.canv.coords(a))
            if point == [x, y]:
                showMessage(self.canv, 500, 300, 300, 150, 'Запрещенный ход')
                self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
                return False
            if (x == self.x) and (self.y - y == 1):
                self.x = x
                self.y = y
                self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
                STEP = False
                return
            for i in self.canv.find_withtag('fig'):
                point = absToRel(self.canv.coords(i))
                if (point == [x, y]) and (self.y - y == 1) and (x != self.x) and (self.id != i):
                    self.x = x
                    self.y = y
                    self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
                    STEP = False
                    return
        showMessage(self.canv, 500, 300, 300, 150, 'Запрещенный ход')
        self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)


    def AI(self):
        # self.canv.delete(self.id)
        kPoint = self.canv.coords(self.canv.find_withtag('bKing')[0])
        kPoint = absToRel(kPoint)
        if [self.x, self.y] == kPoint:
            self.canv.delete(self.id)
            return False
            del self
        else:
            for i in self.canv.find_withtag('fig'):
                point = absToRel(self.canv.coords(i))
                if (self.y - point[1] == 1) and (abs(point[0]-self.x) == 1):
                    self.x = point[0]
                    self.y = point[1]
                    self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
                    return True
                if (self.y - point[1] == 1) and (self.x == point[0]):
                    return True
            self.y -= 1
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            # self.canv.after(1000, self.AI)

class King(Figure):
    def __init__(self, canv, x, y, color, tag = ''):
        super(King, self).__init__(canv, x, y, 'king', color, tag)

    def checkCoords(self, absX, absY):
        global STEP
        global STOP
        global pause
        # print(STOP)
        x = (absX - DX) // SIZE
        y = (absY - DY) // SIZE
        if (abs(self.x - x) <= 1) and (abs(self.y - y) <= 1) and (not (pause)) and (not (STOP)) and (config["color"] != self.color) and ( (x != self.x) or (y != self.y) ) and (x >= 0) and (y >= 0) and (x < 8) and (y < 8):
            # print('Hello');
            a = self.canv.find_withtag('bKing')
            point = absToRel(self.canv.coords(a))
            if ((x-point[0])**2 + (y - point[1])**2) <= 2:
                showMessage(self.canv, 500, 300, 300, 150, 'Запрещенный ход')
                self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
                return False
            pawn = self.canv.find_withtag('pawn')
            pPoint = absToRel(self.canv.coords(pawn))
            if (x == pPoint[0]) and (y == pPoint[1]):
                showMessage(self.canv, 500, 300, 300, 150, 'Запрещенный ход')
                self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
                return False
            self.x = x
            self.y = y
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            STEP = False
            return True
        showMessage(self.canv, 500, 300, 300, 150, 'Запрещенный ход')
        self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
        return False

    def AI(self):
        global PAWN
        global KING
        king = self.canv.find_withtag('wKing')
        pawn = self.canv.find_withtag('pawn')
        kPoint = absToRel(self.canv.coords(king))
        pPoint = absToRel(self.canv.coords(pawn))

        # Идем к пешке
        c = math.hypot(self.x - pPoint[0], self.y - pPoint[1])

        dx = ceil((pPoint[0] - self.x) / c)
        dy = ceil((pPoint[1] - self.y) / c)

        if math.hypot(kPoint[0] - self.x - dx, kPoint[1] - self.y - dy) > 1.5:
            print(0)
            self.x += dx
            self.y += dy
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            if c < 1.5:
                PAWN = False
                self.canv.coords(pawn, -1000, -1000)
            return

        if (dy == 0) :
            self.x -= 1
            self.y -= 1
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            return


        if (math.hypot(kPoint[0] - self.x, kPoint[1] - self.y - dy) > 1.5) and not (1 < math.hypot(pPoint[0] - self.x, pPoint[1] - self.y - dy) < 2 ) and (dy != 0):
            print(1)
            self.y += dy;
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            return

        # Неудача. Контролируем короля
        c = math.hypot(self.x - kPoint[0], self.y - kPoint[1] + 2)
        if c != 0:
            dx = ceil((kPoint[0] - self.x) / c)
            dy = ceil((kPoint[1] - self.y - 2) / c) 
        if (c != 0) and not (1 < math.hypot(pPoint[0] - self.x - dx, pPoint[1] - self.y - dy) < 2 ) and (math.hypot(kPoint[0] - self.x - dx, kPoint[1] - self.y - dy) > 1.5):
            print(2)
            self.x += dx
            self.y += dy
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            return

        # Неудача, отходим в сторону
        dx = ceil(7 - 2 * self.x)
        if not (1 < math.hypot(pPoint[0] - self.x - dx, pPoint[1] - self.y) < 2 ) and (math.hypot(kPoint[0] - self.x - dx, kPoint[1] - self.y) > 1.5):
            print(3)
            self.x += dx
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            return

        if (self.y - 1 >= 0):
            print(4)
            self.y -= 1
            self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
            return

        print(5)
        PAWN = False

    # def AI(self):
    #     global PAWN
    #     king = self.canv.find_withtag('wKing')
    #     pawn = self.canv.find_withtag('pawn')
    #     kPoint = absToRel(self.canv.coords(king))
    #     pPoint = absToRel(self.canv.coords(pawn))
    #     if (math.hypot(self.x - pPoint[0], self.y - pPoint[1]) < 2) and (math.hypot(self.x - pPoint[0], self.y - pPoint[1]) >= 2):
    #         PAWN = False
    #         return
    #     cP = math.hypot(self.x - pPoint[0], self.y - pPoint[1] + 2)
    #     cK = math.hypot(self.x - kPoint[0], self.y - kPoint[1] + 2)
    #     print(cP)
    #     print(cK)
    #     if (cP <= 2) and (cK >= 1):
    #         dx = (pPoint[0] - self.x) / cP
    #         dy = (pPoint[1] - self.y - 2) / cP
    #         dx = -1 if dx < 0 else dx
    #         dy = -1 if dy < 0 else dy
    #         self.x += math.ceil(dx)
    #         self.y += math.ceil(dy)
    #         self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
    #         PAWN = False

    #     else:
    #         if cK >= 1:
    #             dx = (kPoint[0] - self.x) / cK
    #             dy = (kPoint[1] - self.y - 2) / cK
    #             # print(dx, dy)
    #             dx = -1 if dx < 0 else dx
    #             dy = -1 if dy < 0 else dy
    #             self.x += math.ceil(dx)
    #             self.y += math.ceil(dy)
    #             # print(math.ceil(dx), math.ceil(dy))
    #             self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)
    #         else:
    #             dx = (7 - 2 * self.x)/abs(7 - 2 * self.x)
    #             dx = -1 if dx < 0 else dx
    #             self.x += math.ceil(dx)
    #             self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)

    # def AI(self):
    #     king = self.canv.find_withtag('wKing')
    #     pawn = self.canv.find_withtag('pawn')
    #     kPoint = absToRel(self.canv.coords(king))
    #     pPoint = absToRel(self.canv.coords(pawn))
    #     v = np.array([14 - 4 * self.x, 14 - 4 * self.y])
    #     # v = np.array([0, 0])

    #     # print(self.x, self.y, kPoint)
    #     # print((self.x - kPoint[0]))

    #     # v[0] += (7 - (self.x - kPoint[0])) * 2
    #     # v[1] -= (7 - (kPoint[1] - self.y)) * 2

    #     # print(v)
    #     v[0] += 7 -  (pPoint[0] - self.x)
    #     v[1] += 7 -  (pPoint[1] - self.y)

    #     print(v)

    #     if (v[0] == 0) and (v[1] == 0):
    #         return

    #     v = v / math.hypot(v[0], v[1])
    #     v[0] = -1 if v[0] < 0 else v[0]
    #     v[1] = -1 if v[1] < 0 else v[1]
    #     v[0] = math.ceil(v[0])
    #     v[1] = math.ceil(v[1])
    #     self.x += v[0]
    #     self.y += v[1]
    #     self.canv.coords(self.id, DX + self.x * SIZE + SIZE//2, DY + self.y * SIZE + SIZE // 2)


 
pause = False
STOP = True
STEP = config["player"] == 0
ENDGAME = False
KING = True
PAWN = True


def onPauseClick(event):
    global pause
    pause = not pause

def onStopClick(k = -1):
    global STOP
    if k == -1:
        STOP = not STOP
    elif k == 1:
        STOP = True
    else:
        STOP = False
    # print(STOP)

def do(canv, king, pawn):
    global pause
    global STEP
    global ENDGAME
    global KING
    global PAWN
    f = False
    if (not pause) and (not STEP):
        king.AI()
        if not PAWN:
            ENDGAME = True
            showMessage(canv, 500, 300, 300, 150, 'Пешка проиграла!')
        STEP = not STEP

    if (pawn.y != 0) and (KING):
        if not ENDGAME:
            canv.after(100, lambda: do(canv, king, pawn))
    else:
        showMessage(canv, 500, 300, 300, 150, 'Пешка победила!')

def drawStop(canv):
    canv.create_rectangle(
        1018, 52, 1097, 82, fill='#fdf5c2', tag='stopBut')
    canv.create_text(1020, 55, text = 'Стоп', tag = 'stopBut', anchor = 'nw', font = 'Arial 15 italic bold')

def mainloop():
    global pause
    global STEP
    global ENDGAME
    global KING
    global PAWN

    pause = False
    STEP = config["color"] != 0
    ENDGAME = False
    KING = True
    PAWN = True

    canv = Canvas(mainScreen, bg="#fbd3a0")
    canv.pack(expand=YES, fill=BOTH)
    DX = 450
    DY = 96
    borderWidth = 10

    canv.create_rectangle(DX - borderWidth, DY - borderWidth, DX + 8 *
                          SIZE + borderWidth, DY + 8 * SIZE + borderWidth, fill='#3c2418')

    for i in range(0, 8):
        canv.create_text(DX + SIZE * i + (SIZE // 2), DY - 25,
                         text=chr(i + 97).upper(), font='Ravie 15')
        canv.create_text(
            DX - 25, DY + SIZE * i + (SIZE // 2), text=i + 1, font='Ravie 15')

    for i in range(0, 8):
        for j in range(0, 8):
            color = '#fbd3a0' if ((j * 7) + i) % 2 else "#3c2418"
            canv.create_rectangle(
                DX + SIZE * i, DY + SIZE * j, DX + SIZE * i + SIZE, DY + SIZE * j + SIZE, fill=color)

    # Рисуем кнопку стоп
    # canv.create_rectangle(
    #     1038, 52, 1097, 82, fill='#fdf5c2', tag='stopBut')
    # canv.create_text(1040, 55, text = 'Стоп', tag = 'stopBut', anchor = 'nw', font = 'Arial 15 italic bold')

    canv.create_rectangle(
        1018, 52, 1097, 82, fill='#fdf5c2', tag='startBut')
    canv.create_text(1020, 55, text = 'Старт', tag = 'startBut', anchor = 'nw', font = 'Arial 15 italic bold')


# Вернуться обратно
    canv.create_rectangle(
        100, 52, 235, 82, fill='#fdf5c2', tag='backBut')
    canv.create_text(110, 55, text = 'Вернуться', tag = 'backBut', anchor = 'nw', font = 'Arial 15 italic bold')

    # Рисуем паузу
    canv.create_rectangle(1100, 52, 1130, 82, fill='#fdf5c2', tag='pauseBut')
    canv.create_rectangle(1107, 59, 1113, 75, fill = 'black', tag = 'pauseBut')
    canv.create_rectangle(1117, 59, 1123, 75, fill = 'black', tag = 'pauseBut')

    king = King(
        canv, config['kingx'] - 1, config['kingy'] - 1, config['color'], 'bKing ')
    pawn = Pawn(
        canv, config['pawnx'] - 1, config['pawny'] - 1, (config['color'] + 1) % 2)
    wKing = King(
        canv, config['wkingx'] - 1, config['wkingy'] - 1, (config['color'] + 1) % 2, 'wKing ')

    canv.tag_bind('backBut', '<Button - 1>', lambda event: canv.destroy() or mainMenu.mainloop() or onStopClick(1))
    canv.tag_bind('stopBut', '<Button - 1>', lambda event : canv.destroy() or mainloop() or onStopClick(1))
    canv.tag_bind('startBut', '<Button - 1>', lambda event : do(canv, king, pawn) or drawStop(canv) or onStopClick(0))
    canv.tag_bind('pauseBut', '<Button - 1>', onPauseClick)

    # do(canv, king, pawn)
