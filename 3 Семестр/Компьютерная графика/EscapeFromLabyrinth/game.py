from mainScreen import *
from core import *
import mainMenu
from PIL import ImageTk, Image
import os
import threading

class PlayerAnim(object):
    """docstring for PlayerAnim"""
    def __init__(self, canv, loc):
        super(PlayerAnim, self).__init__()
        self.angle = 0
        self.x = 0
        self.y = 0
        self.x0 = 0
        self.y0 = 0
        self.step = 0
        self.canv = canv

        for y, l in enumerate(loc):
            for x, block in enumerate(l):
                if block == 2:
                    self.x = x
                    self.y = y
                    self.x0 = x
                    self.y0 = y
                    break

        self.sprite = []
        playerImg = Image.open('img//player48.png')
        imgs = []
        for i in range(0, 6):
            for j in range(0, 10):
                img = playerImg.crop((48 * j, 48 * i, 48 * (j + 1), 48 * (i + 1)))
                imgs.append(img)

        for i in range(0, 240):
            img = ImageTk.PhotoImage(imgs[i % 60].rotate(-90 * ( i // 60)))
            self.sprite.append(img)

        self.img = self.canv.create_image(self.x * 48, self.y * 48, image = self.sprite[0], anchor = 'nw')

    def playLogs(self, loc, logs, frame, n):

        angle = int(logs[0])
        STEP = 0.05

        self.canv.coords(self.img, self.x * 48, self.y * 48)
        self.canv.itemconfigure(self.img, image = self.sprite[60 * angle + frame])

        if angle == 0:
            self.x += STEP
        elif angle == 1:
            self.y += STEP
        elif angle == 2:
            self.x -= STEP
        else:
            self.y -= STEP

        if n < (1 / STEP) - 1:
            self.canv.after(15, lambda: self.playLogs(loc, logs, (frame + 1) % 60, n + 1))
        else:
            if len(logs) > 1:
                self.playLogs(loc, logs[1::], (frame + 1) % 60, 0)
            else:
                if loc[round(self.y)][round(self.x)] == 3:
                    config["level"] = str(int(config["level"]) + 1)
                    saveConfig()
                    canv.delete('all')
                    game()



def loadMap(name):
    loc = []
    if os.path.isfile('maps//' + name):
        mapFile = open('maps//' + name, 'r')
        for line in mapFile.readlines():
            loc.append([int(i) for i in line.rstrip().split(' ')])
    else:
        global canv
        canv.destroy()
        mainMenu.mainloop()
    return loc

def drawMap(canv, loc):
    for x in range(20):
        for y in range(20):
            canv.create_image(48 * x, 48 * y, image = textureList[1], anchor = 'nw', tag = 'block')

    for i, line in enumerate(loc):
        for j, block in enumerate(line):
            canv.create_image(48 * j, 48 * i, image = textureList[block], anchor = 'nw', tag = 'block')


def onStartButClick():
    global player
    global codeInput
    global canv

    open('tmp.py', 'w').write(codeInput.get(1.0, END))

    os.system('python -m testSystem.py tmp.py')
    logsFile = open('logs//' + config["level"] + '.maptmp.py.log')
    loc = loadMap(logsFile.readline().rstrip())
    logs = logsFile.readline().rstrip()
    errors = logsFile.readline().rstrip()
    logsFile.close()

    if (len(errors) > 0) and (errors != '3'):
        PopupMessage(canv, 0, -50, 0, 30, errors).show(0, 50, 5000)

    player.x = player.x0
    player.y = player.y0
    player.playLogs(loc, logs, 0, 0)

textureList = []
for i in range(0, 4):
    img = ImageTk.PhotoImage(file = 'img//' + str(i) + '.bmp')
    textureList.append(img)


def newThread(f):
    global t
    t = threading.Thread(target = f)
    return t


codeInput = 0
player = 0
canv = 0
t = threading.Thread()
butImg = ImageTk.PhotoImage(file = 'img/startBut.png')

def mainloop():
    global codeInput
    global player
    global canv

    canv = Canvas(mainScreen, bg="#1c60ab", width = 900)
    codeInput = Text(mainScreen, bg = "white", width = 400, fg = "#1c60ab", font = 'Arial 10 bold')
    startBut = Button(mainScreen, image = butImg, bg = '#EEEEEE', font = 'Arial 15 bold', command = lambda : newThread(onStartButClick).start())
    startBut.config(relief = FLAT)

    canv.pack(expand=YES, fill=Y, side = LEFT)
    startBut.pack(side = BOTTOM, expand = NO)
    codeInput.pack(side = LEFT, expand = YES, fill = Y)
    game()

def game():
    global canv
    global player
    global codeInput

    loc = loadMap(config['level'] + '.map')
    codeInput.delete(1.0, END)
    codeInput.insert(END, open('maps//' + config['level'] + '.py', 'r').read())
    drawMap(canv, loc)

    player = PlayerAnim(canv, loc)
