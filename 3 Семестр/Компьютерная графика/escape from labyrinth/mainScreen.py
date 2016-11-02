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
    # for i in mainScreen.pack_slaves():
        # if i.winfo_class() == "Canvas":
            # for j in i.find_all():
                # i.scale(j, D_WIDTH, D_HEIGHT, D_WIDTH, D_HEIGHT)
    width = event.width
    height = event.height

def loadConfig(configName):
    global config
    # print('players\\' + configName + '.ini')
    if os.path.isfile('players\\' + configName + '.ini'):
        configFile = configparser.ConfigParser()
        configFile.read('players\\' + configName + '.ini')
        config = {i[0]: i[1] for i in configFile.items('main')}
    else:
        saveConfig()
        config = {"name" : configName, "level" : 1, "lineCount" : 0}
        saveConfig()


def saveConfig():
    global config
    configFile = configparser.ConfigParser()
    configFile.add_section('main')
    for i in config:
        configFile.set('main', i, str(config[i]))
    with open('players\\' + config['name'] + '.ini', 'w') as f:
        configFile.write(f)
        

config = {"name" : "", "level" : 1, "lineCount" : 0}

WIDTH = 1366
HEIGHT = 716
D_WIDTH = 1
D_HEIGHT = 1
width = WIDTH
height = HEIGHT

# if 'player.ini' in os.listdir():
    # loadConfig('player')
# else:
    # loadConfig('default')

loadConfig('player')
mainScreen = Tk()
mainScreen.wm_title('Побег из лабиринта')
#mainScreen.state('zoomed')
mainScreen.minsize(800, 600)

# Подгоняем под размеры
mainScreen.bind('<Configure>', changesSize)

# mainScreen.after(10, mainScreen.mainloop)
