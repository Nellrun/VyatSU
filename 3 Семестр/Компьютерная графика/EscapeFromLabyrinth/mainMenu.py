from mainScreen import *
from core import *
import os
import game

helpMessage = """
Добро пожаловать в игру Побег из лабиринта.

Главная цель этой игры - научить вас основам программирования.
Просто играите и наслаждайтесь.


Игру разработал студент ИВТ-21, Даниил Щесняк. 
"""


def mainloop():
    global config

    canv = Canvas(mainScreen, bg="white")
    canv.pack(expand=YES, fill=BOTH)

    bg = Background(canv)
    startBut = MenuElement(canv, 50, 600, 'Начать игру')
    settingsBut = MenuElement(canv, 50, 625, 'Другой аккаунт')
    helpBut = MenuElement(canv, 50, 650, 'Справка')
    exitBut = MenuElement(canv, 50, 675, 'Выход')

    # loadConfig('Nellrun')
    # print(config)

    player = PopupMessage(
        canv, 500, -35, 200, 30, "Добро пожаловать, " + config["name"])

    player.show(0, 35, 5000)
    player.onClick(lambda event: InputDialog().onClick(lambda self: canv.destroy() or loadConfig(self.e.get()) or mainloop() or self.top.destroy()))

    startBut.onClick(lambda event: canv.destroy() or game.mainloop())
    settingsBut.onClick(lambda event: InputDialog().onClick(lambda self: canv.destroy() or loadConfig(self.e.get()) or mainloop() or self.top.destroy()))
    helpBut.onClick(
        lambda event: showMessage(canv, 400, 50, 750, 500, helpMessage))
    exitBut.onClick(lambda event: mainScreen.quit())

    # Запуски циклов жизни
    bg.mainloop()
