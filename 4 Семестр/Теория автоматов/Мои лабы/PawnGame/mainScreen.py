from tkinter import *
# from imp import reload
import os
import configparser


def changesSize(event):
    global width
    global height
    D_WIDTH = event.width / width
    D_HEIGHT = event.height / height
    # print(mainScreen.pack_slaves())
    for i in mainScreen.pack_slaves():
        for j in i.find_all():
            i.scale(j, D_WIDTH, D_HEIGHT, D_WIDTH, D_HEIGHT)
    width = event.width
    height = event.height


def loadConfig(configName):
    global config
    configFile = configparser.ConfigParser()
    configFile.read(configName + '.ini')
    config = {i[0]: int(i[1]) for i in configFile.items('main')}


def saveConfig():
    global config
    configFile = configparser.ConfigParser()
    configFile.add_section('main')
    for i in config:
        configFile.set('main', i, str(int(config[i])))
    with open('user.ini', 'w') as f:
        configFile.write(f)

WIDTH = 1366
HEIGHT = 716
D_WIDTH = 1
D_HEIGHT = 1
width = WIDTH
height = HEIGHT

if 'user.ini' in os.listdir():
    loadConfig('user')
else:
    loadConfig('default')
mainScreen = Tk()
mainScreen.wm_title('Pawn Game')
mainScreen.state('zoomed')
mainScreen.minsize(800, 600)

# Подгоняем под размеры
mainScreen.bind('<Configure>', changesSize)

# mainScreen.after(10, mainScreen.mainloop)
